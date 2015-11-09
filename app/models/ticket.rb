class Ticket < ActiveRecord::Base
  before_validation :fill_fields
  after_create :send_created_ticket_email, :start_history
  after_update :send_updated_ticket_email, :add_history_record
  validates :reference_key,
            format: { with: /(([A-Z]{3}-([A-F]|[0-9]){2})-){2}[A-Z]{3}/i},
            uniqueness: { case_sensitive: false },
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

  def self.find_by_filter (filter)
    case filter
      when "open"
        Ticket.where(owner_id: nil).all
      when "on_hold"
        Ticket.where(["status_id = ? or status_id = ?",
                      "#{Status.find_by_name('Waiting for Customer').id}",
                      "#{Status.find_by_name('On Hold').id}"]).all
      when "closed"
        Ticket.where(["status_id = ? or status_id = ?",
                      "#{Status.find_by_name('Cancelled').id}",
                      "#{Status.find_by_name('Completed').id}"]).all
    end
  end

  def update_attributes_by_customer(ticket_params)
    reset_status
    self.update_attributes(ticket_params)
  end

  def to_param
    reference_key
  end
  private

    def start_history
      TicketHistory.create(ticket_id: self.id, description: 'Ticket has been created.')
    end

    def add_history_record
      TicketHistory.create(ticket_id: self.id, description: update_message(self))
    end

    def reset_status
      self.status_id = Status.find_by_name('Waiting for Staff Response').id
    end

    def send_created_ticket_email
      CustomerMailer.created_ticked_email(self).deliver_now
    end

    def send_updated_ticket_email
      message = update_message(self)
      CustomerMailer.updated_ticked_email(self, message).deliver_now
    end

    def update_message(ticket)
      message = ""
      ticket.changed.each do |field|
        case field
          when "customer_name"
            message += "Customer name was changed to #{ticket.customer_name}. "
          when "customer_email"
            message += "Customer email was changed to #{ticket.customer_email}. "
          when "department_id"
            message += "Department was changed to #{ticket.department.name}. "
          when "subject_id"
            message += "Subject was changed to #{ticket.subject.name}. "
          when "owner_id"
            message += "Owner was changed to #{ticket.owner.full_name}. "
          when "status_id"
            message += "Status was changed to #{ticket.status.name}. "
          when "description"
            message += "Description was changed."
        end
      end
      message
    end

    def fill_fields
      if self.new_record?
        self.reference_key = generate_reference_key
        reset_status
      end
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

