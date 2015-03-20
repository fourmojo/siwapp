class CommonsController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :set_extra_stuff, only: [:new, :edit, :create, :update]

  # GET /invoices
  # GET /invoices.json
  # GET /invoices.js
  def index
    set_models model.paginate(page: params[:page], per_page: 20).order(id: :desc)

    respond_to do |format|
      format.html { render layout: 'infinite-scrolling' }
      format.json
      format.js
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    set_model model.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    set_model model.new(invoice_params)

    respond_to do |format|
      if get_model.save
        format.html { redirect_to get_model, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: get_model }
      else
        flash[:alert] = "Invoice has not been created."
        format.html { render :new }
        format.json { render json: get_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /invoices/amounts
  #
  # Calculates the amounts totals
  def amounts
    @invoice = Invoice.new(amounts_params)
    @invoice.set_amounts

    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if get_model.update(invoice_params)
        format.html { redirect_to get_model, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: get_model }
      else
        flash[:alert] = 'Invoice has not been saved.'
        format.html { render :edit }
        format.json { render json: get_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    get_model.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      set_model model.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The Invoice you were looking for could not be found."
      redirect_to recurring_invoices_path
    end

    def set_extra_stuff
      @taxes = Tax.where active: true
      @series = Serie.where enabled: true
    end

    # This is to filter the parameters needed in #amounts
    def amounts_params
      params.require(:invoice).permit(

        items_attributes: [
          :quantity,
          :unitary_cost,
          :discount,
          {:tax_ids => []},
          :_destroy
        ],

        payments_attributes: [
          :amount,
        ]
      )
    end
end
