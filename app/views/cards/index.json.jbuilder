json.array!(@cards) do |card|
  json.extract! card, :id, :name, :description, :image
  json.url card_url(card, format: :json)
end
