require "test_helper"

class UserStocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_stock = user_stocks(:one)
  end

  test "should get index" do
    get user_stocks_url
    assert_response :success
  end

  test "should get new" do
    get new_user_stock_url
    assert_response :success
  end

  test "should create user_stock" do
    assert_difference("UserStock.count") do
      post user_stocks_url, params: { user_stock: { stock_id: @user_stock.stock_id, user_id: @user_stock.user_id } }
    end

    assert_redirected_to user_stock_url(UserStock.last)
  end

  test "should show user_stock" do
    get user_stock_url(@user_stock)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_stock_url(@user_stock)
    assert_response :success
  end

  test "should update user_stock" do
    patch user_stock_url(@user_stock), params: { user_stock: { stock_id: @user_stock.stock_id, user_id: @user_stock.user_id } }
    assert_redirected_to user_stock_url(@user_stock)
  end

  test "should destroy user_stock" do
    assert_difference("UserStock.count", -1) do
      delete user_stock_url(@user_stock)
    end

    assert_redirected_to user_stocks_url
  end
end
