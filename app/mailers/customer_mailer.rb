class CustomerMailer < ApplicationMailer
  def created_ticked_email(ticked)
    @ticked = ticked
    mail(to: @ticked.customer_email, subject: 'You have created new ticket.')
  end

  def updated_ticked_email(ticked, message)
    @ticked = ticked
    @message = message
    mail(to: @ticked.customer_email, subject: 'Your ticked was changed.')
  end
end
