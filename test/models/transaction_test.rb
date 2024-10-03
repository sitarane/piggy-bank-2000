require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  setup do
    @date = Time.now
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

  test 'up_to scope' do
    transactions = Transaction.up_to @date
    assert_includes transactions, transactions(:deposit_5)
    assert_not_includes transactions, @a_deposit
  end

  test 'Transaction sum' do
    assert_equal 9, Transaction.total
    assert_equal 4, Transaction.total(5.days.ago)
    assert_equal 11, Transaction.total(40.days.ago)
    assert_equal 0, Transaction.total(1.year.ago)
  end

  test 'last_year_monthly_history' do
    assert_equal(
      [161.0, 144.0, 127.0, 113.0, 101.0, 86.0, 74.0, 62.0, 50.0, 35.0, 23.0, 8.0],
      Transaction.last_year_monthly_history
    )
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
