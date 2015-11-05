class Ticket < ActiveRecord::Base
  belongs_to :department
  belongs_to :subject
  belongs_to :status
  belongs_to :owner, class_name: "User"
  
end
