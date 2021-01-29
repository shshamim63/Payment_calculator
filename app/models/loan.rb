class Loan < ApplicationRecord
  validates :interest_rate, :amount, :day, :terms, presence: true

  has_many :payments
end
