# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Google map api key: AIzaSyDevygh-3JBsUfmi2INmQs1ER7ZlpT4a7k 

Role.create(name: "admin", description: "Admin role")
Role.create(name: "user", description: "User role")
User.create(email: "admin@gmail.com", password: 12345678)
User.create(email: "user@gmail.com", password: 12345678)
User.first.update(role_id: 1)