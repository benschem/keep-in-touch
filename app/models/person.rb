class Person < ApplicationRecord
  has_many :contacts, dependent: :destroy

  validates :name, presence: true
  validates :relationship, presence: true
end
