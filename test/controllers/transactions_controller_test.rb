require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:withdrawal_7)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url, params: { transaction: { deposit: false, } }
    assert_response :success
  end

  test "should create transaction" do
    assert_difference("Transaction.count") do
      post transactions_url, params: {
        transaction: {
          amount: @transaction.amount,
          comment: @transaction.comment,
          deposit: @transaction.deposit,
          executor: @transaction.executor
          }
        }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  # test "should destroy transaction" do
  #   assert_difference("Transaction.count", -1) do
  #     delete transaction_url(@transaction)
  #   end
  #
  #   assert_redirected_to transactions_url
  # end
end
