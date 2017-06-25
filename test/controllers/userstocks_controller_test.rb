require 'test_helper'

class UserstocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userstock = userstocks(:one)
  end

  test "should get index" do
    get userstocks_url
    assert_response :success
  end

  test "should get new" do
    get new_userstock_url
    assert_response :success
  end

  test "should create userstock" do
    assert_difference('Userstock.count') do
      post userstocks_url, params: { userstock: { stock_id: @userstock.stock_id, user_id: @userstock.user_id } }
    end

    assert_redirected_to userstock_url(Userstock.last)
  end

  test "should show userstock" do
    get userstock_url(@userstock)
    assert_response :success
  end

  test "should get edit" do
    get edit_userstock_url(@userstock)
    assert_response :success
  end

  test "should update userstock" do
    patch userstock_url(@userstock), params: { userstock: { stock_id: @userstock.stock_id, user_id: @userstock.user_id } }
    assert_redirected_to userstock_url(@userstock)
  end

  test "should destroy userstock" do
    assert_difference('Userstock.count', -1) do
      delete userstock_url(@userstock)
    end

    assert_redirected_to userstocks_url
  end
end
