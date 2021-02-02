require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe 'validates Loan' do
    let(:loan) { build(:loan) }

    context 'When povided all the required filed' do
      it 'creats an instance without any error' do
        expect(loan).to be_valid
      end
    end

    context 'When column does not have valid input' do
      it 'invalid instance if loan amount is not given' do
        loan.interest_rate = nil
        expect(loan).not_to be_valid
      end

      it 'invalid instance if terms is not given' do
        loan.terms = nil
        expect(loan).not_to be_valid
      end

      it 'invalid instance if date is not given' do
        loan.day = nil
        expect(loan).not_to be_valid
      end

      it 'invalid instance if interest rate is not given' do
        loan.amount = nil
        expect(loan).not_to be_valid
      end
    end
  end
end
