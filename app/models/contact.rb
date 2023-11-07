require 'action_view'
require 'action_view/helpers'

class Contact < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :person

  validates :date, presence: true
  validates :contact_type, presence: true
  validates :initiated_by, presence: true
  validates :context, presence: true

  def formatted_date
    time_ago_in_words(date)
  end
end
