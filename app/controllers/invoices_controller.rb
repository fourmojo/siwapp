class InvoicesController < CommonsController

  def initialize
    @model = Invoice
    super
  end

  def commons=(stuff)
    @invoices = stuff
  end

  def common=(stuff)
    @invoice = stuff
  end

  def common
    @invoice
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

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(
        :serie_id,
        :due_date,

        :customer_name,
        :customer_email,

        :invoicing_address,
        :draft,

        items_attributes: [
          :id,
          :description,
          :quantity,
          :unitary_cost,
          :discount,
          {:tax_ids => []},
          :_destroy
        ],

        payments_attributes: [
          :id,
          :date,
          :amount,
          :notes,
          :_destroy
        ]
      )
    end

end
