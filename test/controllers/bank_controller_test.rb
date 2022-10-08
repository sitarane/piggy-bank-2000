require "test_helper"

class BankControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get bank_show_url
    assert_response :success
  end
end
