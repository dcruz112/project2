json.array!(@confusions) do |confusion|
  json.extract! confusion, 
  json.url confusion_url(confusion, format: :json)
end
