require "faker"
require 'date'
require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

puts "Cleaning database..."
Person.destroy_all
Contact.destroy_all

puts "Creating some people..."
10.times do
  Person.create({ name: Faker::Name.name, relationship: ["friend", "family"].sample })
  puts "#{Person.last.name} created with relationship #{Person.last.relationship}"
end

puts "Creating some contact history..."
Person.all.each do |person|
  (1..10).to_a.sample.times do
    person.contacts.create(
      {
        date: rand(1.months).seconds.ago,
        contact_type: ["call", "message", "in person"].sample,
        initiated_by: ["you", "them", "other"].sample,
        context: ["group", "solo"].sample
      }
    )
    puts "Contact added for #{person.name}. Last contact: #{time_ago_in_words(person.contacts.last.date)} ago, Type: #{person.contacts.last.contact_type}, Initiated by: #{person.contacts.last.initiated_by}, Context: #{person.contacts.last.context}."
  end
end
