class RecurringInvoicesController < CommonsController

  def initialize
    @model = RecurringInvoice
    super
  end

  def path
    recurring_invoices_path
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
