class CustomerMailer < ApplicationMailer
  def created_ticked_email(ticked)
    @ticked = ticked
    # @user = user
    # @url  = 'http://example.com/login'
    binding.pry
    mail(to: @ticked.customer_email, subject: 'You have created new ticket.')
  end

  def updated_ticked_email(ticked)
    # @user = user
    # @url  = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
