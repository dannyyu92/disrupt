class User
  include Mongoid::Document
  include Mongoid::Token
  include Mongoid::Timestamps

  # Fields
  token :field_name => :pubid, :pattern => "DU%C3%d5%C3%d4"
  field :name, type: String
  field :phone_number, type: String

  # Relations
  has_many :tasks

  def self.hours_string(hours, estimate)
    if hours < estimate
      hours_left = estimate - hours
      "You have #{hours_left} hours left."
    elsif hours > estimate
      hours_over = hours - estimate
      "You've gone over by #{hours_over}."
    else
      "You are amazing at time tracking."
    end
  end
end