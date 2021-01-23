require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe "validates Loan" do
    let(:loan) { Loan.new(loan_amount: "10000", terms: 12, interest_rate: '10', 
                interest_only: 'Yes', day: DateTime.current.beginning_of_day) }

    context 'When povided all the required filed' do
      it "creats an instance without any error" do
        loan = Loan.new(loan_amount: "10000", terms: 12, interest_rate: '10', interest_only: 'Yes', day: DateTime.current.beginning_of_day)
        expect(loan).to be_valid
      end
    end

    context 'When column does not have valid input' do
      it "invalid instance if loan amount is not given" do
        loan.interest_rate = nil
        expect(loan).not_to be_valid
      end

      it "invalid instance if interest only is not given" do
        loan.interest_only = nil
        expect(loan).not_to be_valid
      end

      it "invalid instance if terms is not given" do
        loan.terms = nil
        expect(loan).not_to be_valid
      end

      it "invalid instance if date is not given" do
        loan.day = nil
        expect(loan).not_to be_valid
      end

      it "invalid instance if interest rate is not given" do
        loan.interest_rate = nil
        expect(loan).not_to be_valid
      end
    end
  end

  describe "Number of payments based on terms" do
    context "creates same number of payment instances based on the given loan terms" do
      it "if terms is 12 creates 12 featured payments" do
        loan = Loan.create(loan_amount: "10000", terms: 12, interest_rate: '10', 
                          interest_only: 'Yes',    day: DateTime.current.beginning_of_day)
        
        payments = Payment.final_payment_list(loan.loan_amount.to_f,
                                               loan.terms.to_f,
                                               loan.interest_rate.to_f,
                                               Date.parse(loan.day.to_s).beginning_of_month,
                                               loan.interest_only
                                             )
        
        expect(payments.count).to eql(loan.terms)
      end
    end
  end
end
