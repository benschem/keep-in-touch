class Contact < ApplicationRecord
  belongs_to :person

  validates :date, presence: true
  validates :contact_type, presence: true
  validates :initiated_by, presence: true
  validates :context, presence: true
end
