class User
  include Mongoid::Document
  include Mongoid::Token
  include Mongoid::Timestamps

  # Fields
  token :field_name => :pubid, :pattern => "DU%C3%d5%C3%d4"
  field :name, type: String
  field :phone_number, type: String

end