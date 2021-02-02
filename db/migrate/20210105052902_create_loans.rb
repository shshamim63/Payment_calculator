class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.decimal :loan_amount
      t.integer :terms
      t.decimal :interest_rate
      t.date :day
      t.string :interest_only

      t.timestamps
    end
  end
end
