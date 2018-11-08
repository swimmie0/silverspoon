require 'test_helper'

class FreeboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @freeboard = freeboards(:one)
  end

  test "should get index" do
    get freeboards_url
    assert_response :success
  end

  test "should get new" do
    get new_freeboard_url
    assert_response :success
  end

  test "should create freeboard" do
    assert_difference('Freeboard.count') do
      post freeboards_url, params: { freeboard: { content: @freeboard.content, name: @freeboard.name, title: @freeboard.title, user_id: @freeboard.user_id } }
    end

    assert_redirected_to freeboard_url(Freeboard.last)
  end

  test "should show freeboard" do
    get freeboard_url(@freeboard)
    assert_response :success
  end

  test "should get edit" do
    get edit_freeboard_url(@freeboard)
    assert_response :success
  end

  test "should update freeboard" do
    patch freeboard_url(@freeboard), params: { freeboard: { content: @freeboard.content, name: @freeboard.name, title: @freeboard.title, user_id: @freeboard.user_id } }
    assert_redirected_to freeboard_url(@freeboard)
  end

  test "should destroy freeboard" do
    assert_difference('Freeboard.count', -1) do
      delete freeboard_url(@freeboard)
    end

    assert_redirected_to freeboards_url
  end
end
