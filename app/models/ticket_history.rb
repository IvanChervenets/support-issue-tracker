class TicketHistory < ActiveRecord::Base
  validates :description,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,150})\z/i, message: 'Only allows letters and numbers' },
            length: { in: 1..150, message: 'Length must be between 1 and 150' },
            presence: true
  validates :ticket_id, presence: true
  belongs_to :ticket
end
