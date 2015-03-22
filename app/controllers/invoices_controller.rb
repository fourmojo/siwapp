class InvoicesController < CommonsController

  def initialize
    @model = Invoice
    super
  end

  def path
    invoices_path
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
