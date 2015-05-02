class Project
  include Mongoid::Document
  include Mongoid::Token
  include Mongoid::Timestamps

  # Fields
  token :field_name => :pubid, :pattern => "BGP%C3%d5%C3%d4"
  field :title, type: String

  # Relations
  has_many :tasks

end