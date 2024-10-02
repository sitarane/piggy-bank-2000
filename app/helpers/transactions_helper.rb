module TransactionsHelper
  def month_collumn_height_string(monthly_value)
    "height:" + ( (monthly_value / @last_year_monthly_history.max) * 100 ).to_s + "%"
  end
end
