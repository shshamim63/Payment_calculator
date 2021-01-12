class FeaturedPayments
  attr_reader :payments
  def initialize()
    @payments = []
  end

  def create_instance(cal_amount, cal_interest, cal_pmt, cal_principal, cal_day, cal_end_balance)
    payment = Payment.new start_balance: cal_amount,
                       interest: cal_interest,
                       total_pmt: cal_pmt,
                       principal: cal_principal,
                       day: cal_day,
                       end_balance: cal_end_balance        
  end
  
  def final_payment_list (amount, terms, rate, date, interest_only)
    years = terms.to_f/12
    effected_term = interest_only == 'Yes' ? terms - 3 : terms
    pmt = self.total_pmt(amount, rate, years, effected_term)
    (0...terms).each do |term|
      if interest_only == 'Yes' and term < 3
        interest = interest_monthly(amount, rate, terms).round(2)
        payment = create_instance(amount, interest, interest,
                                      0.00, date.next_month, amount)
        payments.push(payment)
      else
        interest = interest_monthly(amount, rate, effected_term).round(2)
        principal = (pmt - interest).round(2)
        end_balance = (amount - principal).round(2) >= 0 ? (amount - principal).round(2) : 0
        payment = create_instance(amount, interest, pmt.round(2),
                                      principal, date.next_month, end_balance)
      
        payments.push(payment)
        amount = end_balance
      end
      date = date.next_month
    end
    payments
  end

  def total_pmt(start_balance, annual_interest_rate, years, terms)
    monthly_interest = monthly_rate(annual_interest_rate, terms)
    modified_interest_amount = (1 + monthly_interest) ** terms
    change = change_of_rate(modified_interest_amount)
    (start_balance *(monthly_interest * modified_interest_amount)) / change
  end

  def interest_monthly(current_start_balance, annual_interest_rate, terms)
    (current_start_balance*(annual_interest_rate/(terms*100).to_f))
  end

  def monthly_rate(annual_interest_rate, terms)
    annual_interest_rate/(terms*100).to_f
  end

  def change_of_rate(monthly_interest_amount)
    monthly_interest_amount - 1
  end
end