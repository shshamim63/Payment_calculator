class PaymentGeneratorService
  def initialize(loan:)
    @loan = loan
    @amount = @loan.amount
    @terms = @loan.terms
    @rate = @loan.interest_rate
    @date = @loan.day
    @interest_only = @loan.interest_only
  end

  def create
    years = @terms / 12
    effected_term = @interest_only ? @terms - 3 : @terms
    payment_monthly = total_monthly_payment(@amount, @rate, years, effected_term)
    (0...@terms).each do |term|
      payment =
        if @interest_only and term < 3
          interest = interest_monthly(@amount, @rate, @terms).round(2)
          @loan.payments.build(
            start_balance: @amount,
            interest: interest,
            total_pmt: interest,
            principal: 0.00,
            day: @date.next_month,
            end_balance: @amount
          )
        else
          interest = interest_monthly(@amount, @rate, effected_term).round(2)
          principal = (payment_monthly - interest).round(2)
          end_balance = (@amount - principal).round(2) >= 0 ? (@amount - principal).round(2) : 0
          payment = @loan.payments.build(
            start_balance: @amount,
            interest: interest,
            total_pmt: payment_monthly.round(2),
            principal: principal,
            day: @date.next_month,
            end_balance: end_balance
          )
          @amount = end_balance
          payment
        end
      @date = @date.next_month
      payment.save
    end
  end

  def interest_monthly(current_start_balance, annual_interest_rate, terms)
    (current_start_balance * (annual_interest_rate / (terms * 100)))
  end

  private

  def total_monthly_payment(start_balance, annual_interest_rate, _years, terms)
    monthly_interest = monthly_rate(annual_interest_rate, terms)
    modified_interest_amount = (1 + monthly_interest)**terms
    change = modified_interest_amount - 1
    (start_balance * (monthly_interest * modified_interest_amount)) / change
  end

  def monthly_rate(annual_interest_rate, terms)
    annual_interest_rate / (terms * 100)
  end
end
