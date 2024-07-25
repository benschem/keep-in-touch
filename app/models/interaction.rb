require 'action_view'
require 'date'
# require 'action_view/helpers'

class Interaction < ApplicationRecord
  # include ActionView::Helpers::DateHelper

  belongs_to :person

  validates :date, presence: true
  validates :method, presence: true
  validates :initiated_by, presence: true
  validates :context, presence: true

  def days_ago
    # time_ago_in_words(date)
    # (Date.today - DateTime.parse(date)).to_i
    (Date.today - date.to_date).to_i
  end
end
