class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: :index

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
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
      if @ticket.update_attributes(ticket_params)
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
end
