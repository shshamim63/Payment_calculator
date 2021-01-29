require 'rails_helper'

RSpec.describe PaymentGeneratorService do
  describe '#create' do
    let(:loan) { create(:loan) }
    context 'creates payments under a loan' do
      it 'number of payments is equal to the addressed terms' do
        described_class.new(loan: loan).create
        expect(loan.payments.count).to eq(loan.terms)
      end
    end

    context 'When interest_only loan' do
      it 'should contains the first three instances with the same interest rate' do
        payment_generator_service = described_class.new(loan: loan)
        payment_generator_service.create
        payments = loan.payments
        monthly_interest = payment_generator_service.interest_monthly(
          loan.amount,
          loan.interest_rate,
          loan.terms
        ).round(2)
        targeted_payment = payments.select { |payment| payment.total_pmt == monthly_interest }
        expect(targeted_payment.count).to eql(3)
      end
    end

    context 'When without interest_only loan' do
      let(:without_interest_only_loan) { create(:loan, interest_only: false) }
      it 'should contains the first three instances with the same interest rate' do
        payment_generator_service = described_class.new(loan: without_interest_only_loan)
        payment_generator_service.create
        payments = without_interest_only_loan.payments
        monthly_interest = payment_generator_service.interest_monthly(
          loan.amount,
          loan.interest_rate,
          loan.terms
        ).round(2)
        targeted_payment = payments.select { |payment| payment.interest == monthly_interest }
        expect(targeted_payment.count).to eql(1)
      end
    end
  end
end
