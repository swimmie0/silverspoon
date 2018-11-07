require 'test_helper'

class UserrequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userrequest = userrequests(:one)
  end

  test "should get index" do
    get userrequests_url
    assert_response :success
  end

  test "should get new" do
    get new_userrequest_url
    assert_response :success
  end

  test "should create userrequest" do
    assert_difference('Userrequest.count') do
      post userrequests_url, params: { userrequest: {  } }
    end

    assert_redirected_to userrequest_url(Userrequest.last)
  end

  test "should show userrequest" do
    get userrequest_url(@userrequest)
    assert_response :success
  end

  test "should get edit" do
    get edit_userrequest_url(@userrequest)
    assert_response :success
  end

  test "should update userrequest" do
    patch userrequest_url(@userrequest), params: { userrequest: {  } }
    assert_redirected_to userrequest_url(@userrequest)
  end

  test "should destroy userrequest" do
    assert_difference('Userrequest.count', -1) do
      delete userrequest_url(@userrequest)
    end

    assert_redirected_to userrequests_url
  end
end
