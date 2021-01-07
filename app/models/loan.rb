class Loan < ApplicationRecord
  validates :interest_only,:interest_rate, :loan_amount, :day, :terms, presence: true
end
