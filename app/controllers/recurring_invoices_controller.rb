class RecurringInvoicesController < CommonsController

  def initialize
    @model = RecurringInvoice
    super
  end

  def commons=(stuff)
    @recurring_invoices = stuff
  end

  def common=(stuff)
    @recurring_invoice = stuff
  end

  def common
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
