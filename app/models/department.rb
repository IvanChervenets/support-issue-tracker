class Department < ActiveRecord::Base
  validates :name,
            presence: true,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,40})\z/i, message: 'Only allows letters and numbers' },
            length: { in: 2..40, message: 'Length must be between 2 and 40' },
            uniqueness: { case_sensitive: false }

  has_many :tickets
end
