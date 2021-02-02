class ChangeInterestOnlyToBeBooleanInLoans < ActiveRecord::Migration[6.0]
  def change
    change_column :loans, :interest_only, :boolean, using: 'interest_only::boolean'
  end
end
