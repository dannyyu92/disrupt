class Task
  include Mongoid::Document
  include Mongoid::Token
  include Mongoid::Timestamps

  # Statuses
  INACTIVE = "inactive"
  STARTED = "started"
  REVIEW = "review"
  DONE = "done"
  ALL_STATUSES = [INACTIVE, STARTED, REVIEW, DONE]

  # Fields
  token :field_name => :pubid, :pattern => "DT%d4"
  field :status, type: String, default: Task::NOT_STARTED
  field :minutes, type: Integer # In minutes
  field :estimate, type: Integer # In minutes
  field :description, type: String

  # Relations
  belongs_to :user
  belongs_to :project, autosave: true

  def self.create_task_for_api(task_hash)

  end
end