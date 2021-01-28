class LoanSerializer < ActiveModel::Serializer
  attributes :id, :amount, :terms, :interest_rate, :day, :interest_only

  def amount
    object.amount.to_f
  end

  def terms
    object.terms.to_f
  end

  def interest_rate
    object.interest_rate.to_f
  end

  def day
    Date.parse(object.day.to_s).beginning_of_month
  end

  def interest_only
    object.interest_only || false
  end
end
