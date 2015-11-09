class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: :index

  def index
    if params[:filter].presence
      if params[:filter] == 'my'
        @tickets = Ticket.where("owner_id = ?", "#{current_user.id}")
        @tab = 'my'
      else
        @tickets = Ticket.find_by_filter(params[:filter])
        @tab = params[:filter]
      end
    else
      @tickets = Ticket.find_by_filter('open')
      @tab = 'open'
    end
    # binding.pry
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
    @notification = ""
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket
    else
      render :new
    end
  end

  def update
    if signed_in?
      if @ticket.update_attributes(staf_ticket_params)
        redirect_to @ticket
      else
        render action: "edit"
      end
    else
      if @ticket.update_attributes_by_customer(ticket_params)
        redirect_to @ticket
      else
        render action: "edit"
      end
    end
  end

  # def send_notification
  #   message = params[:comments][:cols]
  #   CustomerMailer.notification_email(@ticket, message).deliver_now
  # end

  # def destroy
  #   @ticket.destroy
  #   redirect_to tickets_url
  # end

  private

  def set_ticket
    @ticket = Ticket.find_by(reference_key: params[:reference_key])
  end

  def ticket_params
    params.require(:ticket).permit(:customer_name,
                                   :customer_email,
                                   :department_id,
                                   :subject_id,
                                   :description)
  end

  def staf_ticket_params
    params.require(:ticket).permit(:owner_id,
                                   :status_id)
  end
end
