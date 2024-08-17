# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

15.times do
  Driver.create(
    name: Faker::Name.first_name_neutral,
    affiliation: Faker::Company.name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone,
    )
end

50.times do
  Truck.create(
    plate: Faker::Vehicle.license_plate,
    capacity: Faker::Number.number(digits: 3),
    is_available: true
  )
end

# first administrator
User.create(full_name: 'admin', email: 'admin@admin.com', password: '000000', role: 'ADMIN')

# regular users
20.times do
  User.create(
    full_name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '000000',
    role: 'USER',
    confirmed_at: Time.now
  )
end
