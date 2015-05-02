json.id             project.pubid
json.title          project.title   if project.title.present?

json.tasks do
  json.array! project.tasks, partial: 'api/v1/tasks/task', as: :task
end if project.tasks.present?