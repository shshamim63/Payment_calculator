class PaymentController < ApplicationController
  def index

  end

  def calculate
    @payments = Payment.final_payment_list(params[:loan_amount].to_f,
                                            params[:terms].to_f,
                                            params[:interest].to_f,
                                            Date.parse(params[:datetime]),
                                            params[:interest_only]
                                          )
    
    render 'welcome/index'
  end
end
