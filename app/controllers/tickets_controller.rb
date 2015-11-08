class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @tickets = Ticket.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @ticket = Ticket.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      redirect_to @ticket
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
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
