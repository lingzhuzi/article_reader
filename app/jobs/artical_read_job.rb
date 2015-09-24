class ArticalReadJob < ActiveJob::Base
  queue_as :default

  after_enqueue do |job|
    Task.where(job_id: job.job_id).update_all(status: Task::WAITING)
  end

  before_perform do |job|
    Task.where(job_id: job.job_id).update_all(status: Task::RUNNING)
  end

  after_perform do |job|
    Task.where(job_id: job.job_id).update_all(status: Task::ENDED)
  end

  rescue_from(Exception) do |exception|
    content = "message: #{exception.message}\n"
    content << "backtraces: \n"
    content << exception.backtrace.join("\n")

    Task.where(job_id: self.job_id).update_all(status: Task::ERROR, error: content)
  end


  def perform(*args)
    @reader_config = args.first
    readed_pages = 0

    while true
      pages = @reader_config.index_pages
      break if pages.present? && readed_pages >= pages

      url = @next_page_url || @reader_config.index_url
      reader = IndexPageReader.new(@reader_config, url)
      reader.parse
      articals = reader.articals
      @next_page_url = reader.next_page_url

      read_articals(articals)
      readed_pages += 1

      break if articals.blank? || @next_page_url.blank?
    end
  end

  def read_articals(articals)
    return if articals.blank?

    articals.each do |artical|
      reader = ArticalPageReader.new(@reader_config, artical[:url])
      reader.parse

      record = Artical.find_or_initialize_by(url: artical[:url], reader_config: @reader_config)
      record.title = artical[:title]
      record.content = reader.content
      record.images = reader.images.join(',')
      record.save!
    end
  end

end
