class HomeController < ApplicationController
  def home
  end

  def contact
    if signed_in?
      redirect_to root_path
    else
      @ticket = Ticket.new
    end
  end
end
