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

  def self.minutes_string(minutes, estimate)
    if minutes < estimate
      minutes_left = estimate - minutes
      "You have #{minutes_left} minutes left."
    elsif minutes > estimate
      minutes_over = minutes - estimate
      "You've gone over by #{minutes_over}."
    else
      "You are amazing at time tracking."
    end
  end
end