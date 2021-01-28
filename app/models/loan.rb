class Loan < ApplicationRecord
  validates :interest_rate, :amount, :day, :terms, presence: true
end
