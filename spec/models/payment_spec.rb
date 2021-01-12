require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe "validates Payment" do
    let(:payment) { Payment.new(start_balance: 100000.00,
                                principal: 5400.00,
                                interest: 10.50,
                                total_pmt: 786.50,
                                end_balance: 1350.00
                                ) 
                  }

    context 'When povided all the required filed' do
      it "creats an instance without any error" do
        expect(payment).to be_valid
      end
    end

    context 'When column does not have valid input' do
      it "invalid instance if start balance is not given" do
        payment.start_balance = nil
        expect(payment).not_to be_valid
      end

      it "invalid instance if principal is not given" do
        payment.principal = nil
        expect(payment).not_to be_valid
      end

      it "invalid instance if interest is not given" do
        payment.interest = nil
        expect(payment).not_to be_valid
      end

      it "invalid instance if total_pmt is not given" do
        payment.total_pmt = nil
        expect(payment).not_to be_valid
      end

      it "invalid instance if interest rate is not given" do
        payment.end_balance = nil
        expect(payment).not_to be_valid
      end
    end
  end
end