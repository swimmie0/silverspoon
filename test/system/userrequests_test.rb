require "application_system_test_case"

class UserrequestsTest < ApplicationSystemTestCase
  setup do
    @userrequest = userrequests(:one)
  end

  test "visiting the index" do
    visit userrequests_url
    assert_selector "h1", text: "Userrequests"
  end

  test "creating a Userrequest" do
    visit userrequests_url
    click_on "New Userrequest"

    click_on "Create Userrequest"

    assert_text "Userrequest was successfully created"
    click_on "Back"
  end

  test "updating a Userrequest" do
    visit userrequests_url
    click_on "Edit", match: :first

    click_on "Update Userrequest"

    assert_text "Userrequest was successfully updated"
    click_on "Back"
  end

  test "destroying a Userrequest" do
    visit userrequests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Userrequest was successfully destroyed"
  end
end
