class Transaction < ApplicationRecord
  validates :amount, presence: true, numericality: true
  # validates :amount, comparison: { greater_than: 0, :less_than_or_equal_to 1000 }
  validates :executor, presence: true
  validates :comment, presence: true

  def self.total
    sum = 0
    all.each do |transaction|
      if transaction.deposit
        sum += transaction.amount
      else
        sum -= transaction.amount
      end
    end
    sum
  end
end
