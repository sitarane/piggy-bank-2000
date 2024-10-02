DATE_OF_BIRTH = Date.strptime(ENV["DATE_OF_BIRTH"],"%Y-%m-%d").freeze
ALLOWANCE = ENV["ALLOWANCE"].to_f.freeze
START_DATE = Date.strptime(ENV["START_DATE"],"%Y-%m-%d").freeze
CURRENCY = ENV["CURRENCY"].freeze