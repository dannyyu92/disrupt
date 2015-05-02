json.projects do
  json.array! @projects, partial: 'api/v1/projects/project', as: :project
end