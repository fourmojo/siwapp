class RecurringInvoicesController < CommonsController

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

  private

    def invoice_params
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

end
