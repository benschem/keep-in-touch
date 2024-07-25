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
  # generate a random date and time within the past (x) months and format it into a DateTime object.
  DateTime.parse(rand(x.months).seconds.ago.strftime("%Y-%m-%d %H:%M:%S"))
end

puts "Cleaning database..."
Person.destroy_all
Interaction.destroy_all

puts "Creating some people..."
10.times do
  Person.create({ name: Faker::Name.name, relationship: ["friend", "family"].sample })
  puts "#{Person.last.name} created with relationship #{Person.last.relationship}"
end

puts "Creating some interactions..."
Person.all.each do |person|
  # Each person has 1-10 interactions
  (1..10).to_a.sample.times do
    Interaction.create(
      {
        person: person,
        date: random_datetime_within_the_last_x_months(3),
        method: ["call", "message", "in person"].sample,
        initiated_by: ["you", "them", "other"].sample,
        context: ["group", "solo"].sample
      }
    )
    puts "Interaction added for #{person.name}. Interaction date: #{person.interactions.last.days_ago} days ago, Method: #{person.interactions.last.method}, Initiated by: #{person.interactions.last.initiated_by}, Context: #{person.interactions.last.context}."
  end
end
