class BankController < ApplicationController
  def show
    date_of_birth = Date.strptime(ENV["DATE_OF_BIRTH"],"%Y-%m-%d")
    allowance = ENV["ALLOWANCE"].to_f
    start_date = Date.strptime(ENV["START_DATE"],"%Y-%m-%d")


    @credit = CreditCalculator.new(date_of_birth, allowance, start_date).call + Transaction.total
  end
end
