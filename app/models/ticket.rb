class Ticket < ActiveRecord::Base
  before_validation :fill_fields
  after_save :send_created_ticket_email
  validates :reference_key,
            format: { with: /(([A-Z]{3}-([A-F]|[0-9]){2})-){2}[A-Z]{3}/i},
            presence: true
  validates :customer_name,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,40})\z/i, message: 'Only allows letters and numbers' },
            length: { in: 1..40, message: 'Length must be between 1 and 40' },
            presence: true
  validates :customer_email,
            format: { with: /\A([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)\z/i, message: 'Not email format' },
            presence: true
  validates :description,
            format: { with: /\A([A-Z][a-z ,.'`-]{2,150})\z/i, message: 'Only allows letters and numbers' },
            length: { in: 1..150, message: 'Length must be between 1 and 150' },
            presence: true
  validates :department_id, :subject_id, :status_id, presence: true
  belongs_to :department
  belongs_to :subject
  belongs_to :status
  belongs_to :owner, class_name: "User"
  has_many :ticket_histories

  def to_param
    reference_key
  end
  private

    def send_created_ticket_email
      CustomerMailer.created_ticked_email(self).deliver_now
    end

    def fill_fields
      self.reference_key = generate_reference_key
      self.status_id = '1'
    end

    def generate_reference_key
      key = ''
      loop do
        key = /((\w{3}-((A|B|C|D|E|F)|\d){2})-){2}\w{3}/.gen.upcase
        break unless Ticket.where(reference_key: key).first
      end
      key
    end

end

