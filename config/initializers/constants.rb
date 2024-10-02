DATE_OF_BIRTH = Rails.env.test? ? (7.years.ago + 3.weeks).to_date : Date.strptime(ENV["DATE_OF_BIRTH"],"%Y-%m-%d").freeze
ALLOWANCE = Rails.env.test? ? 0.5 : ENV["ALLOWANCE"].to_f.freeze
START_DATE = Rails.env.test? ? (1.year.ago + 1.week).to_date : Date.strptime(ENV["START_DATE"],"%Y-%m-%d").freeze
CURRENCY = ENV["CURRENCY"].freeze