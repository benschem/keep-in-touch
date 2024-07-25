class Person < ApplicationRecord
  belongs_to :user

  has_many :interactions, -> { order('date DESC') }, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
  validates :relationship, presence: true
end
