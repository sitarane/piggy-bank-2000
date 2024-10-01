require "test_helper"

class CreditCalculatorTest < ActiveSupport::TestCase

  test '6 years old kids at 0.5/yoa/week gets 3€ in one week' do
    date_of_birth = DateTime.new(2015, 4, 2)
    allowance = 0.5
    start_date = date_of_birth + 6.years + 20.days
    travel_to start_date + 1.week do
      assert_equal 3, CreditCalculator.new(date_of_birth, allowance, start_date).call
    end
  end
  test '10 years old that started getting .2€/yoa/w 10 weeks ago now has 20€' do
    date_of_birth = DateTime.new(2006, 6, 24)
    allowance = 0.2
    start_date = date_of_birth + 10.years + 2.months
    travel_to start_date + 10.weeks do
      assert_equal 20, CreditCalculator.new(date_of_birth, allowance, start_date).call
    end
  end
  test '10 years old that started getting .2€/yoa/w 10 weeks ago has 10€ 5 weeks ago' do
    date_of_birth = DateTime.new(2006, 6, 24)
    allowance = 0.2
    start_date = date_of_birth + 10.years + 2.months
    travel_to start_date + 10.weeks do
      assert_equal 10, CreditCalculator.new(date_of_birth, allowance, start_date, 5.weeks.ago).call
    end
  end
  test '7 years old that started getting 0.5/yoa/w two weeks ago,\
    but their birthday was last week got 3 + 3.5 = 6.5€' do
    date_of_birth = DateTime.new(2012, 11, 5)
    allowance = 0.5
    start_date = date_of_birth + 7.years - 1.week
    travel_to start_date + 2.weeks do
      assert_equal 6.5, CreditCalculator.new(date_of_birth, allowance, start_date).call
    end
  end
  test '11 years old that started getting 0.25€/yoa/w on their 9th birthday\
    got a full year of 2.25 a week (117€), then a full year at 2.5 a week\
    (130€), then the rest (3 weeks) at 2,75 a week (8,25) so 255,25€' do
    date_of_birth = DateTime.new(2011, 9, 16)
    allowance = 0.25
    start_date = date_of_birth + 9.years
    travel_to start_date + 2.years + 3.weeks do
      assert_equal(
        255.25,
        CreditCalculator.new(date_of_birth, allowance, start_date).call
      )
    end
  end
end