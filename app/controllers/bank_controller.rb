class BankController < ApplicationController
  def show
    date_of_birth = Date.strptime(ENV["DATE_OF_BIRTH"],"%Y-%m-%d")
    allowance = ENV["ALLOWANCE"].to_f
    start_date = Date.strptime(ENV["START_DATE"],"%Y-%m-%d")


    @credit = compute_credit(date_of_birth, allowance, start_date) + Transaction.total
  end

  private

  def compute_credit(date_of_birth, allowance, start_date)
    credit = 0
    ## He gets his money on Saturday date.wday == 6
    (start_date..Date.today).select{ |date| date.wday == 6 }.each do | date |
      age = date.year - date_of_birth.year
      age -= 1 if date < date_of_birth + age.years # for days before birthday
      allowance_for_this_week = age * allowance
      credit += allowance_for_this_week
      ## For debug:
      # puts "date is #{date}, Damien is #{age}, he gets #{allowance_for_this_week} added to his stash of #{credit}"
    end
    credit
  end
end
