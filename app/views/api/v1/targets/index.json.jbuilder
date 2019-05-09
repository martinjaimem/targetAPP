json.targets @targets do |target|
  json.id target.id
  json.title target.title
  json.topic_id target.topic_id
  json.lat target.lat
  json.lng target.lng
  json.user_id target.user_id
end
