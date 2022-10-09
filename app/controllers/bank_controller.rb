class BankController < ApplicationController
  def show
    date_of_birth = Date.new(2013, 07, 04)
    allowance = 0.5 # in Euros per year of age per week

    start_date = Date.new(2021, 1)
    # Actually started oct 2020, but stopped paying him after 2 months

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
       ## For debug:
       # puts "date is #{date}, Damien is #{age}, he gets #{allowance_for_this_week} added to his stash of #{credit}"
       credit += allowance_for_this_week
    end
    credit / 2 # Elsy gives him half
  end
end
