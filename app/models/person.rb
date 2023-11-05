class Person < ApplicationRecord
  has_many :contacts

  validates :name, presence: true
  validates :relationship, presence: true
end
