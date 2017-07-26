# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(name:  "Jason Loblein",
#              email: "jason@loblein.com",
#              password:              "password",
#              password_confirmation: "password",
#              admin: true,
#              activated: true,
#              activated_at: Time.zone.now,
#              street_address: "117 Oakwood Ave, fl 3",
#              city: "West Hartford",
#              state: "CT",
#              zipcode: "06119")

# User.create!(name:  "Brody Gibbs",
#              email: "gibbsbrody31@gmail.com",
#              password:              "password",
#              password_confirmation: "password",
#               admin: true,
#              activated: true,
#              activated_at: Time.zone.now,
#              street_address: "117 Oakwood Ave, fl 3",
#              city: "West Hartford",
#              state: "CT",
#              zipcode: "04915")
#
# User.create!(name:  "Ian Robbins",
#              email: "ian.robbins.1983@gmail.com",
#              password:              "password",
#              password_confirmation: "password",
#             admin: true,
#              activated: true,
#              activated_at: Time.zone.now,
#              street_address: "154 Washington Ave",
#              city: "Portland",
#              state: "ME",
#              zipcode: "04101")
#
# User.create!(name:  "Katherine Loblein",
#              email: "kloblein@yahoo.com",
#              password:              "password",
#              password_confirmation: "password",
#               admin: true,
#              activated: true,
#              activated_at: Time.zone.now,
#              street_address: "9 East Avenue",
#              city: "Belfast",
#              state: "ME",
#              zipcode: "04915")
#
# User.create!(name:  "John Gibbs",
#              email: "j.gibbs1968222@yahoo.com",
#              password:              "password",
#              password_confirmation: "password",
#              admin: true,
#              activated: true,
#              activated_at: Time.zone.now,
#              street_address: "117 Oakwood Ave, fl 3",
#              city: "West Hartford",
#              state: "CT",
#              zipcode: "06119")

# 20.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now,
#                street_address: "9 East Avenue",
#                 city: "Belfast",
#                 state: "ME",
#                 zipcode: "04915")

Badge.delete_all

Badge.create!(title: 'Deer Hunter',
              image: 'https://s3.amazonaws.com/gametiks/images/badges/first_deer.png')

Badge.create!(title: 'Bear Hunter',
              image: 'https://s3.amazonaws.com/gametiks/images/badges/first_bear.png')

Badge.create!(title: 'Turkey Hunter',
              image: 'https://s3.amazonaws.com/gametiks/images/badges/first_turkey.png')

Badge.create!(title: 'Moose Hunter',
              image: 'https://s3.amazonaws.com/gametiks/images/badges/first_moose.png')
