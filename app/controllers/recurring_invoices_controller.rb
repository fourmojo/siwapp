class RecurringInvoicesController < CommonsController
  before_action :set_recurring_invoice, only: [:show, :edit, :update, :destroy]
  before_action :set_extra_stuff, only: [:new, :edit, :create, :update]

  def model
    RecurringInvoice
  end

  def set_models(stuff)
    @recurring_invoices = stuff
  end

  def set_model(stuff)
    @recurring_invoice = stuff
  end

  def get_model
    @recurring_invoice
  end

  def update
    if @recurring_invoice.update(recurring_invoice_params)
      flash[:notice] = "Recurring Invoice has been updated."
      redirect_to @recurring_invoice
    else
      flash[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def destroy
    @recurring_invoice.destroy
    flash[:notice] = "Recurring Invoice has been destroyed."
    redirect_to recurring_invoices_path
  end


  private

    def recurring_invoice_params
      params
        .require(:recurring_invoice)
        .permit(
          :serie_id,

          :customer_name,
          :customer_email,

          :days_to_due,
          :invoicing_address,
          :draft,
          :starting_date,
          :finishing_date
        )
    end

    def set_recurring_invoice
      @recurring_invoice = RecurringInvoice.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The Recurring Invoice you were looking" +
        " for could not be found."
      redirect_to recurring_invoices_path
    end

    def set_extra_stuff
      @taxes = Tax.where active:true
      @series = Serie.where enabled: true
    end
end
