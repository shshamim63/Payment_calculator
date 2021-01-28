class RenameLoanAmountToAmountInLoans < ActiveRecord::Migration[6.0]
  def change
    rename_column :loans, :loan_amount, :amount
  end
end
