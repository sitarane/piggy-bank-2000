module TransactionsHelper
  def last_year_monthly_history
    history = []
    12.times do |index|
      time = index.months.ago
      value =  CreditCalculator.new(@date_of_birth, @allowance, @start_date, time.to_date).call + Transaction.total(time)
      history << value
    end
    return history
  end

  def month_collumn_height_string(monthly_value)
    "height:" + ( (monthly_value / last_year_monthly_history.max) * 100 ).to_s + "%"
  end
end
