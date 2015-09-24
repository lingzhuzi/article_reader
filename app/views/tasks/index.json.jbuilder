json.array!(@tasks) do |task|
  json.extract! task, :id, :job_id, :reader_config_id, :status
  json.url task_url(task, format: :json)
end
