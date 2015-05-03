# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u1 = User.create(
  name: "Rich",
  phone_number: "17329665575",
  pubid: "DUDTI75445ECX6555"
)

u2 = User.create(
  name: "Kevin",
  phone_number: "12033395298",
  pubid: "DUHAL68180LFS6953"
)

u3 = User.create(
  name: "Al",
  phone_number: "19146181757",
  pubid: "DUVJT93474LOT2472"
)

u4 = User.create(
  name: "Danny",
  phone_number: "16462697113",
  pubid: "DUVJT93474GUY2472"
)

p = Project.create(
  title: "Disrupt Project"
)

t1 = Task.create(
  description: "Make Rails server",
  status: "inactive",
  project_id: p.id,
  user_id: u4.id
)

t2 = Task.create(
  description: "Make dashboard screen for ios app",
  status: "started",
  project_id: p.id,
  user_id: u1.id
)

t3 = Task.create(
  description: "Make project screen for ios app",
  status: "review",
  project_id: p.id,
  user_id: u2.id
)

t4 = Task.create(
 description: "Win hackathon",
 status: "done",
 project_id: p.id,
 user_id: u3.id
)