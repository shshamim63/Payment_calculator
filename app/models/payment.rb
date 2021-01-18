class Payment < ApplicationRecord  
  validates :start_balance, :principal, :interest, :total_pmt, :end_balance, presence: true
end
