class LoansController <  ApplicationController
  before_action :set_loan, only: [:show]
  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.create(loan_params)
    if @loan.save
      redirect_to loan_path(@loan)
    else
      render 'new'
    end
  end

  def show
    @loan = Loan.new
    @payments = Payment.final_payment_list(@current_loan.amount,
                                           @current_loan.terms,
                                           @current_loan.interest_rate,
                                           @current_loan.day,
                                           @current_loan.interest_only
                                          )
  end

  private

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate, :interest_only, :day, :terms)
  end

  def set_loan
    @current_loan = Loan.find(params[:id])
  end
end