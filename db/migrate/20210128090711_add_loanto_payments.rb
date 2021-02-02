class AddLoantoPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :loan, index: true
  end
end
