require 'test_helper'

class ZizuminfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @zizuminfo = zizuminfos(:one)
  end

  test "should get index" do
    get zizuminfos_url
    assert_response :success
  end

  test "should get new" do
    get new_zizuminfo_url
    assert_response :success
  end

  test "should create zizuminfo" do
    assert_difference('Zizuminfo.count') do
      post zizuminfos_url, params: { zizuminfo: {  } }
    end

    assert_redirected_to zizuminfo_url(Zizuminfo.last)
  end

  test "should show zizuminfo" do
    get zizuminfo_url(@zizuminfo)
    assert_response :success
  end

  test "should get edit" do
    get edit_zizuminfo_url(@zizuminfo)
    assert_response :success
  end

  test "should update zizuminfo" do
    patch zizuminfo_url(@zizuminfo), params: { zizuminfo: {  } }
    assert_redirected_to zizuminfo_url(@zizuminfo)
  end

  test "should destroy zizuminfo" do
    assert_difference('Zizuminfo.count', -1) do
      delete zizuminfo_url(@zizuminfo)
    end

    assert_redirected_to zizuminfos_url
  end
end
