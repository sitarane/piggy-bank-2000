class BankController < ApplicationController
  def show
    @credit = CreditCalculator.new(DATE_OF_BIRTH, ALLOWANCE, START_DATE).call + Transaction.total
  end
end
