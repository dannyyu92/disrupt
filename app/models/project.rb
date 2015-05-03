class Project
  include Mongoid::Document
  include Mongoid::Token
  include Mongoid::Timestamps

  # Fields
  token :field_name => :pubid, :pattern => "DP%d4"
  field :title, type: String

  # Relations
  has_many :tasks
  accepts_nested_attributes_for :tasks

  def percent_complete
    return nil if tasks.empty?
    done_tasks = tasks.where(status: Task::DONE).count
    total_tasks = tasks.count
    (done_tasks.to_f / total_tasks.to_f * 100.0).round
  end

end