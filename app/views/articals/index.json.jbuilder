json.array!(@articals) do |artical|
  json.extract! artical, :id, :title, :url, :content, :reader_config_id
  json.url artical_url(artical, format: :json)
end
