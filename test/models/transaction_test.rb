require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test 'Transaction sum' do
    assert Transaction.total == -2
  end
end
