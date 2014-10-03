json.array!(@todos) do |todo|
  json.extract! todo, :id, :name, :description, :time, :box_id, :done
  json.url todo_url(todo, format: :json)
end
