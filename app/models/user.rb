class User < ActiveRecord::Base
  validates :first_name, :second_name,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,30})\z/i, message: 'Only allows letters' },
            length: { in: 1..30, message: 'Length must be between 1 and 30' },
            presence: true

  validates :username,
            format: { with: /\A[a-zA-Z0-9]+\Z/, message: 'Only allows letters and numbers' },
            length: { in: 1..20, message: 'Length must be between 1 and 20' },
            uniqueness: { case_sensitive: false },
            presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable,
         :validatable, :authentication_keys => [:username]

  has_many :tickets
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def full_name
    "#{self.first_name} #{self.second_name}"
  end
end
