class LoansController <  ApplicationController
  before_action :set_loan, only: [:show]
  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.create(loan_params)
    if @loan.save
      redirect_to @loan
    end
  end

  def show
    @loan = Loan.new
    @payments = Payment.final_payment_list(@seted_loan.loan_amount.to_f,
                                           @seted_loan.terms.to_f,
                                           @seted_loan.interest_rate.to_f,
                                           Date.parse(@seted_loan.day.to_s).beginning_of_month,
                                           @seted_loan.interest_only
                                          )
  end

  private

  def loan_params
    params.require(:loan).permit(:loan_amount, :interest_rate, :interest_only, :day, :terms)
  end

  def set_loan
    @seted_loan = Loan.find(params[:id])
  end
end