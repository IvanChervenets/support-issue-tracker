class Ticket < ActiveRecord::Base
  validates :reference_key,
            format: { with: /(([A-Z]{3}-([A-F]|[0-9]){2})-){2}[A-Z]{3}/i},
            presence: true
  validates :customer_name,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,40})\z/i, message: 'Only allows letters and numbers' },
            length: { in: 1..40, message: 'Length must be between 1 and 40' },
            presence: true
  validates :customer_email,
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Not email format' },
            uniqueness: { case_sensitive: false },
            presence: true
  validates :description,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,150})\z/i, message: 'Only allows letters and numbers' },
            length: { in: 1..150, message: 'Length must be between 1 and 150' },
            presence: true
  validates :ticket_id, :subject_id, :status_id, presence: true
  belongs_to :department
  belongs_to :subject
  belongs_to :status
  belongs_to :owner, class_name: "User"
  has_many :ticket_histories
end
