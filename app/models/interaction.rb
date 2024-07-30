require 'date'

class Interaction < ApplicationRecord
  enum :method, { message: 0, call: 1, in_person: 2 }
  enum :initiated_by, { them: 0, you: 1, someone_else: 2 }, prefix: true
  enum :context, { in_a_group: 0, solo: 1 }

  belongs_to :person

  validates :date, presence: true
  validates :method, presence: true
  validates :initiated_by, presence: true
  validates :context, presence: true

  def days_ago
    (Date.today - date.to_date).to_i
  end
end
