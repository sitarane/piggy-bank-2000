require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  setup do
    @a_deposit = Transaction.create(
      amount: 10,
      comment: "I'm a transaction!",
      deposit: true,
      executor: 'Test Inc.'
    )
    @other_one = Transaction.create(
      amount: 10,
      cancels_out: @a_deposit,
      comment: 'Deletes a previous transaction',
      deposit: false,
      executor: 'The system'
    )
  end

  test 'Transaction sum' do
    assert_equal 9, Transaction.total
  end

  test 'get_original' do
    assert_equal @a_deposit, @a_deposit.get_original
    assert_equal @a_deposit, @other_one.get_original
    uncancelled = transactions(:withdrawal_7)
    assert_equal uncancelled, uncancelled.get_original
  end

  test 'get_last_five' do
    assert Transaction.all.length > 5
    assert Transaction.get_last_five.length == 5
  end
end
