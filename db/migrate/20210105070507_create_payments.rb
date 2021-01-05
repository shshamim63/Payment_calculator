class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.date :day
      t.decimal :start_balance
      t.decimal :principal
      t.decimal :interest
      t.decimal :total_pmt
      t.decimal :end_balance

      t.timestamps
    end
  end
end
