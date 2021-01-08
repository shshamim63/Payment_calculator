require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe '.final_payment_list' do
    let(:interest_only_loan) { Loan.new(loan_amount: "10000", terms: 12, interest_rate: '10', 
                interest_only: 'Yes', day: DateTime.current.beginning_of_day) }
    let(:without_interest_only_loan) { Loan.new(loan_amount: "10000", terms: 12, interest_rate: '10', 
                interest_only: 'No', day: DateTime.current.beginning_of_day) }
    context "When interest_only contain Yes" do
      it 'should contains the first three instances with the same interest rate' do
        payments = Payment.final_payment_list(interest_only_loan.loan_amount.to_f,
                                              interest_only_loan.terms.to_f,
                                              interest_only_loan.interest_rate.to_f,
                                              Date.parse(interest_only_loan.day.to_s).beginning_of_month,
                                              interest_only_loan.interest_only
                                             )

        monthly_interest = Payment.interest_monthly(interest_only_loan.loan_amount.to_f,interest_only_loan.interest_rate.to_f, interest_only_loan.terms.to_f).round(2)

        targeted_payment = payments.select { |payment| payment.interest == monthly_interest }
        expect(targeted_payment.count).to eql(3)
      end
    end

    context "When interest_only contain No" do
      it 'should contains the first instance with the same interest rate' do
        payments = Payment.final_payment_list(without_interest_only_loan.loan_amount.to_f,
                                              without_interest_only_loan.terms.to_f,
                                              without_interest_only_loan.interest_rate.to_f,
                                              Date.parse(without_interest_only_loan.day.to_s).beginning_of_month,
                                              without_interest_only_loan.interest_only
                                             )

        monthly_interest = Payment.interest_monthly(without_interest_only_loan.loan_amount.to_f,without_interest_only_loan.interest_rate.to_f, without_interest_only_loan.terms.to_f).round(2)

        targeted_payment = payments.select { |payment| payment.interest == monthly_interest }
        expect(targeted_payment.count).to eql(1)
      end
    end
  end

  describe '.total_pmt' do
    let(:interest_only_loan) { Loan.new(loan_amount: "12000", terms: 12, interest_rate: '10', 
                interest_only: 'Yes', day: DateTime.current.beginning_of_day) }
    let(:without_interest_only_loan) { Loan.new(loan_amount: "12000", terms: 12, interest_rate: '10', 
                interest_only: 'No', day: DateTime.current.beginning_of_day) }
    context 'For without interest only loans' do
      it 'Each of the payment should contain same total pmt' do
        payments = Payment.final_payment_list(without_interest_only_loan.loan_amount.to_f,
                                              without_interest_only_loan.terms.to_f,
                                              without_interest_only_loan.interest_rate.to_f,
                                              Date.parse(without_interest_only_loan.day.to_s).beginning_of_month,
                                              without_interest_only_loan.interest_only
                                            )
        years = without_interest_only_loan.terms.to_f / 12
        total_pmt = Payment.total_pmt(without_interest_only_loan.loan_amount,
                                      without_interest_only_loan.interest_rate,
                                      years,
                                      without_interest_only_loan.terms.to_f
                                     )
        target_payment = payments.select { |payment| payment.total_pmt.round(2) == total_pmt.round(2) }
        expect(target_payment.count).to eql(without_interest_only_loan.terms)
      end
    end

    context 'For with interest only loans' do
      it 'expect the first three rest of the payments should contain same total_pmt' do
        payments = Payment.final_payment_list(interest_only_loan.loan_amount.to_f,
                                              interest_only_loan.terms.to_f,
                                              interest_only_loan.interest_rate.to_f,
                                              Date.parse(interest_only_loan.day.to_s).beginning_of_month,
                                              interest_only_loan.interest_only
                                            )
        years = interest_only_loan.terms.to_f / 12
        total_pmt = Payment.total_pmt(interest_only_loan.loan_amount,
                                      interest_only_loan.interest_rate,
                                      years,
                                      (interest_only_loan.terms-3).to_f
                                     )
                                     
        target_payment = payments.select { |payment| payment.total_pmt.round(2) == total_pmt.round(2) }
        expect(target_payment.count).to eql(interest_only_loan.terms - 3)
      end
    end
  end
end