require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @withdrawal = transactions(:withdrawal_7)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url, params: { transaction: { deposit: false } }
    assert_response :success
  end

  test "should create transaction" do
    assert_difference("Transaction.count") do
      post transactions_url, params: {
        transaction: {
          amount: @withdrawal.amount,
          comment: @withdrawal.comment,
          deposit: @withdrawal.deposit,
          executor: @withdrawal.executor,
          secret_code: 'password'
          }
        }
    end

    assert_redirected_to transactions_url
  end

  test "should revert transaction" do
    assert_difference("Transaction.count") do
      delete transaction_url(@withdrawal)
    end

    assert_redirected_to transactions_url
    revert = Transaction.last
    assert revert.amount = -(@withdrawal.amount)
    assert revert.cancels_out = @withdrawal
  end

  test 'should cancel reverted transaction' do
    delete transaction_url(@withdrawal)
    revert = Transaction.last
    assert_difference("Transaction.count", -1) do
      delete transaction_url(revert)
    end
    assert_redirected_to transactions_url
    assert @withdrawal.cancels_out == nil
  end
end
