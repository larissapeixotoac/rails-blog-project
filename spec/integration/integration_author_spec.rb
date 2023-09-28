require 'rails_helper'

RSpec.describe "Creating an Author", type: :feature do
  
  scenario "valid inputs" do
    visit authors_path
    click_on "New author"
    fill_in "Name", with: "John Doe"
    click_on "Create Author"
    visit authors_path
    expect(page).to have_content("John Doe")
  end

  scenario "valid inputs" do
    visit new_author_path

    fill_in "Name", with: "Jane Doe"
    click_on "Back to authors"
    expect(page).not_to have_content("Jane Doe")
  end
end