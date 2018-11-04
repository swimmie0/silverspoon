require "application_system_test_case"

class FreeboardsTest < ApplicationSystemTestCase
  setup do
    @freeboard = freeboards(:one)
  end

  test "visiting the index" do
    visit freeboards_url
    assert_selector "h1", text: "Freeboards"
  end

  test "creating a Freeboard" do
    visit freeboards_url
    click_on "New Freeboard"

    fill_in "Content", with: @freeboard.content
    fill_in "Name", with: @freeboard.name
    fill_in "Title", with: @freeboard.title
    fill_in "User", with: @freeboard.user_id
    click_on "Create Freeboard"

    assert_text "Freeboard was successfully created"
    click_on "Back"
  end

  test "updating a Freeboard" do
    visit freeboards_url
    click_on "Edit", match: :first

    fill_in "Content", with: @freeboard.content
    fill_in "Name", with: @freeboard.name
    fill_in "Title", with: @freeboard.title
    fill_in "User", with: @freeboard.user_id
    click_on "Update Freeboard"

    assert_text "Freeboard was successfully updated"
    click_on "Back"
  end

  test "destroying a Freeboard" do
    visit freeboards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Freeboard was successfully destroyed"
  end
end
