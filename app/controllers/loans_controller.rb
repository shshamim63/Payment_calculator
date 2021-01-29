class LoansController < ApplicationController
  before_action :set_loan, only: [:show]
  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.create(loan_params)
    if @loan.save
      PaymentGeneratorService.new(loan: @loan).create
      redirect_to @loan
    else
      render 'new'
    end
  end

  def show
    @loan = Loan.new
    @payments = @current_loan.payments
  end

  private

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate, :interest_only, :day, :terms)
  end

  def set_loan
    @current_loan = Loan.find(params[:id])
  end
end
