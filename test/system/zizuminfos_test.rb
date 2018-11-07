require "application_system_test_case"

class ZizuminfosTest < ApplicationSystemTestCase
  setup do
    @zizuminfo = zizuminfos(:one)
  end

  test "visiting the index" do
    visit zizuminfos_url
    assert_selector "h1", text: "Zizuminfos"
  end

  test "creating a Zizuminfo" do
    visit zizuminfos_url
    click_on "New Zizuminfo"

    click_on "Create Zizuminfo"

    assert_text "Zizuminfo was successfully created"
    click_on "Back"
  end

  test "updating a Zizuminfo" do
    visit zizuminfos_url
    click_on "Edit", match: :first

    click_on "Update Zizuminfo"

    assert_text "Zizuminfo was successfully updated"
    click_on "Back"
  end

  test "destroying a Zizuminfo" do
    visit zizuminfos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Zizuminfo was successfully destroyed"
  end
end
