json.array!(@reader_configs) do |reader_config|
  json.extract! reader_config, :id, :name, :index_url, :index_pages, :index_next_page_selector, :index_next_page_content, :index_artical_link_selector, :artical_content_selectors, :artical_next_page_selector, :artical_next_page_content, :artical_pages
  json.url reader_config_url(reader_config, format: :json)
end
