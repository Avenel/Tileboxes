json.array!(@boxes) do |box|
  json.extract! box, :id, :name, :description, :done, :color, :start_date, :pos_x, :pos_y
  json.url box_url(box, format: :json)
end
