# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u1 = User.create(
  name: "Rich",
  phone_number: "17329665575"
)

u2 = User.create(
  name: "Kevin",
  phone_number: "12033395298"
)

u3 = User.create(
  name: "Al",
  phone_number: "19146181757"
)

p = Project.create(
  title: "Disrupt Project"
)

t1 = Task.create(
  description: "Make Rails server",
  project_id: p.id,
  user_id: u1.id
)

t2 = Task.create(
  description: "Make dashboard screen for ios app",
  project_id: p.id,
  user_id: u2.id
)

t3 = Task.create(
  description: "Make project screen for ios app",
  project_id: p.id,
  user_id: u3.id
)