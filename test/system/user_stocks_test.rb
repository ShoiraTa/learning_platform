require "application_system_test_case"

class UserStocksTest < ApplicationSystemTestCase
  setup do
    @user_stock = user_stocks(:one)
  end

  test "visiting the index" do
    visit user_stocks_url
    assert_selector "h1", text: "User stocks"
  end

  test "should create user stock" do
    visit user_stocks_url
    click_on "New user stock"

    fill_in "Stock", with: @user_stock.stock_id
    fill_in "User", with: @user_stock.user_id
    click_on "Create User stock"

    assert_text "User stock was successfully created"
    click_on "Back"
  end

  test "should update User stock" do
    visit user_stock_url(@user_stock)
    click_on "Edit this user stock", match: :first

    fill_in "Stock", with: @user_stock.stock_id
    fill_in "User", with: @user_stock.user_id
    click_on "Update User stock"

    assert_text "User stock was successfully updated"
    click_on "Back"
  end

  test "should destroy User stock" do
    visit user_stock_url(@user_stock)
    click_on "Destroy this user stock", match: :first

    assert_text "User stock was successfully destroyed"
  end
end
