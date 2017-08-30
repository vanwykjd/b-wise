# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
1.times do
        User.create!(
            name: "David",
            username: "vwykjd",
            email: "vwykjj@email.com",
            password: "password",
            password_confirmation: "password",
            unconfirmed_email: false,
            confirmed_at: Faker::Time.between(DateTime.now - 1, DateTime.now)
        )
    end
users = User.all

puts "Seed finished"
puts "#{User.count} users created"