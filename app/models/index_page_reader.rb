class IndexPageReader

  attr_accessor :articals, :next_page_url

  def initialize(reader_config, url)
    @reader_config = reader_config
    @url = url
  end

  def parse
    Rails.logger.info "get index page : #{@url}"
    doc = Common.html_document(@url)
    if doc
      parse_articals(doc)
      parse_next_page_url(doc)
    end
  end

  private
  def parse_articals(doc)
    @articals = []
    links = doc.css(@reader_config.index_artical_link_selector)
    links.each do |link|
      title = link.content || link.attr('title')
      url   = Common.complete_url(@url, link.attr('href'))

      content = @reader_config.index_artical_link_content
      reg     = Common.regexp(content)

      if content.blank? || reg.match(title)
        @articals << { title: title, url: url }
      end
    end
  end

  def parse_next_page_url(doc)

    links = doc.css(@reader_config.index_next_page_selector)
    links.each do |link|
      title = link.content || link.attr('title')
      url   = Common.complete_url(@url, link.attr('href'))

      content = @reader_config.index_next_page_content
      reg     = Common.regexp(content)

      if content.blank? || reg.match(title)
        @next_page_url = url
        break
      end
    end

  end
end