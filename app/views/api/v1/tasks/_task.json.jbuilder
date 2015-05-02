json.id               task.pubid
json.status           task.status
json.minutes          task.minutes if task.minutes.present?
json.estimate         task.estimate if task.estimate.present?
json.description      task.description if task.description.present?

 json.user do
  json.partial! 'api/v1/users/user', user: task.user 
end if task.user.present?