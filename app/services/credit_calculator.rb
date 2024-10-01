class CreditCalculator
    def initialize(date_of_birth, allowance, start_date, end_date = Date.today)
      @date_of_birth = date_of_birth
      @allowance = allowance
      @start_date = start_date
      @end_date = end_date
    end
  
    def call
        credit = 0
        ## He gets his money on Saturday date.wday == 6
        (@start_date..@end_date).select{ |date| date.wday == 6 }.each do | date |
          age = date.year - @date_of_birth.year
          age -= 1 if date < @date_of_birth + age.years # for days before birthday
          allowance_for_this_week = age * @allowance
          credit += allowance_for_this_week
          ## For debug:
          # puts "date is #{date}, Damien is #{age}, he gets #{allowance_for_this_week} added to his stash of #{credit}"
        end
        credit
    end
  end
  