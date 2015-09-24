require 'open-uri'

class ArticalPageReader

  attr_accessor :content, :images

  def initialize(reader_config, url, page=1)
    @reader_config = reader_config
    @url = url
    @page = page || 1
  end

  def parse
    Rails.logger.info "get artical page : #{@url}"
    artical_pages = @reader_config.artical_pages
    return if artical_pages && @page > artical_pages
    doc = Common.html_document(@url)
    if doc
      parse_content(doc)
      download_images(doc)
      parse_next_page_url(doc)
      if @next_page_url
        reader = self.class.new(@reader_config, @next_page_url, @page + 1)
        reader.parse
        @content << "\n"
        @content << reader.content
        @images.concat(reader.images)
      end
    end
  end

  private
  def parse_content(doc)
    @content = ''
    selectors = @reader_config.artical_content_selectors.split(',')
    selectors.each do |selector|
      doc.css(selector).each do |node|
        @content << "\n"
        @content << node.content
      end
    end
  end

  def download_images(doc)
    dir_download = "public/download"
    dir_work = dir_download + "/#{@reader_config.id}"
    Dir.mkdir(dir_download) unless Dir.exist?(dir_download)
    Dir.mkdir(dir_work) unless Dir.exist?(dir_work)
    @images = []
    selectors = @reader_config.artical_img_selectors.split(',')
    selectors.each do |selector|
      doc.css(selector).each do |img_node|
        href = img_node.attr('src')
        url = Common.complete_url(@url, href)

        temp_file = open(url)
        if temp_file
          file_name = dir_work + "/" + url.split('/').last
          text = temp_file.read
          save_to_file(file_name, text, true)
          temp_file.close
          @images << file_name.gsub /^public\//, ''
        end
      end
    end
  end

  def save_to_file(file_name, text, binary=false)
    File.open(file_name, binary ? 'wb' : 'w') do |file|
      file.puts text
    end
  end

  def parse_next_page_url(doc)
    selector = @reader_config.artical_next_page_selector
    return if selector.blank?

    content  = @reader_config.artical_next_page_content
    regexp   = Common.regexp(content)

    doc.css(selector).each do |link|
      if content.blank? || regexp.match(link)
        @next_page_url = Common.complete_url(@url, link.attr('href'))
        break
      end
    end
  end
end