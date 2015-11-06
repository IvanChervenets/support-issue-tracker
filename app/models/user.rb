class User < ActiveRecord::Base
  validates :first_name, :second_name,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,20})\z/i, message: 'Only allows letters and numbers' },
            length: { in: 1..20, message: 'Length must be between 1 and 20' },
            presence: true

  validates :username,
            format: { with: /\A[a-zA-Z0-9]+\Z/, message: 'Only allows letters and numbers' },
            length: { in: 1..20, message: 'Length must be between 1 and 20' },
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
end
