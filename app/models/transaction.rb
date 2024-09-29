class Transaction < ApplicationRecord

  has_one :cancels_out, class_name: 'Transaction', foreign_key: :cancels_out_id, dependent: :nullify

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

  def self.get_last_five
    candidates = Transaction.last(10)
    transactions = []
    count = 0
    until candidates.empty? || count == 5
      transaction = candidates.last
      original = transaction.get_original
      transactions << original
      candidates -= [transaction, original]
      count += 1
    end
    return transactions
  end

  def get_original
    other_one = self.cancels_out
    return self unless other_one
    return self if self.created_at < other_one.created_at
    return other_one
  end
end
