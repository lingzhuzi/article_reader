require 'open-uri'

class Common

  def self.html_document(url)
    return Nokogiri::HTML(open(url, :read_timeout => 60))
  rescue => e
    Rails.logger.error e.message
    Rails.logger.error e.backtrace.join("\n")
  end


  def self.complete_url(base_url, url)

    return nil if !valid_url?(url)

    href = url.downcase
    if href.start_with?('http://') || href.start_with?('https://')
      return url
    elsif href.start_with?('//')
      URI.parse(base_url).scheme + ":" + url
    else
      return URI.join(base_url, url).to_s
    end
  rescue => e
    puts e.message
    puts e.backtrace.join("\n")
  end

  def self.valid_url?(url)
    url = url.downcase
    ['javascript:', '#', 'mailto:', 'irc:'].each do |str|
      return false if url.start_with?(str)
    end

    true
  end

  def self.regexp(str)
    Regexp.new str.gsub('*', '.*') if str.present?
  end

end