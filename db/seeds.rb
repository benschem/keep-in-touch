# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "faker"
require 'date'
require 'action_view'
require 'action_view/helpers'

def random_datetime_within_the_last_x_months(x)
  start_date = DateTime.now - x.months
  end_date = DateTime.now

  random_time = start_date + rand * (end_date - start_date)
  random_time
end

puts "Deleting everything in all tables..."
User.destroy_all
Person.destroy_all
Interaction.destroy_all

puts "Creating a test user..."
User.create!(
    email: "john.smith@test.com",
    password: "123456",
    first_name: "John",
    last_name: "Smith"
)
puts "User `#{User.last.first_name} #{User.last.last_name}` created with email #{User.last.email} and password #{User.last.password}."


puts "Creating some people..."
10.times do
  relationship = ["friend", "family"].sample
  person = Person.new(
    name: Faker::Name.name,
    relationship: relationship,
  )
  person.user = User.last
  person.save!
  puts "#{person.name} with relationship #{person.relationship} to #{person.user.first_name} #{person.user.last_name}."
end

puts "Creating some interactions..."
people = Person.all
people.each do |person|
  # Each person has 1-10 interactions
  rand(1..10).times do
    interaction_date = random_datetime_within_the_last_x_months(3)
    method = ["in_person", "call", "message"].sample
    initiated_by = ["you", "them", "other"].sample
    context = ["solo", "in_a_group"].sample

    interaction = Interaction.new(
      person: person,
      date: interaction_date,
      method: method,
      initiated_by: initiated_by,
      context: context
    )
    interaction.save!
    puts "Interaction added for #{interaction.person.name}. Interaction date: #{interaction.days_ago} days ago, Method: #{interaction.method}, Initiated by: #{interaction.initiated_by}, Context: #{interaction.context}."
  end
end
