json.array!(@fees) do |fee|
  json.extract! fee, :id, :fee_name
  json.url fee_url(fee, format: :json)
end
