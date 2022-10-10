class Transaction < ApplicationRecord
  validates :amount, presence: true, numericality: true
  # validates :amount, comparison: { greater_than: 0, :less_than_or_equal_to 1000 }
  validates :executor, presence: true
  validates :comment, presence: true

  def self.total
    total = 0
    all.each do |transaction|
      if transaction.deposit
        total += transaction.amount
      else
        total -= transaction.amount
      end
    end
    total
  end
end
