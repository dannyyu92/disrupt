class Task
  include Mongoid::Document
  include Mongoid::Token
  include Mongoid::Timestamps

  # Statuses
  ACTIVE = "active"
  INACTIVE = "inactive"
  COMPLETED = "completed"
  ALL_STATUSES = [ACTIVE, INACTIVE, COMPLETED]

  # Fields
  token :field_name => :pubid, :pattern => "BGT%C3%d5%C3%d4"
  field :status, type: String, default: Task::ACTIVE
  field :minutes, type: Integer # In minutes
  field :estimate, type: Integer # In minutes
  field :description, type: String

  # Relations
  belongs_to :user
  belongs_to :project, autosave: true

  def self.create_task_for_api(task_hash)
    
  end
end