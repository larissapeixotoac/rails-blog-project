require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'create new user' do
    before(:each) do
      visit new_user_registration_path # go to sign up
      within('form') do # helper method: looking for somehting to do somthing else
        fill_in "Email", with: "unit.tt@test.com"
        fill_in "Name", with: "Unit Test"
        fill_in "Password", with: '123123'
      end
    end

    scenario 'should be successfull' do
      fill_in "Password confirmation", with: '123123'
      click_button "Sign up"
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
    
    scenario 'should fails' do
      click_button "Sign up"
      expect(page).to have_content("prohibited this user from being saved:")
    end
  end

  context 'sign in' do
    before(:each) do
      @user = User.create(email: 't@t.com', name: 'update test', password: '132123') 
      visit new_user_session_path
      within('form') do
        fill_in "Email", with: @user.email
      end
    end  

    scenario 'should be successful' do
      fill_in 'Password', with: @user.password
      click_button('commit')
      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'should fail' do
      click_button('commit')
      expect(page).to have_content('Invalid Email or password.')
    end
  end

  context 'update user' do
    let!(:user) { User.create(email: 'tt@t.com', name: 'update test', password: '132123') }
    before(:each) do
      login_as(user, scope: :user)
      visit edit_user_registration_path
      within('#edit_user') do
        fill_in "Name", with: "Unit Test"
      end
    end
    
    scenario 'should be successful' do
      fill_in 'Current password', with: user.password
      click_button "Update"
      expect(page).to have_content("Your account has been updated successfully.")
    end

    scenario 'should fale' do
      click_button "Update"
      expect(page).to have_content("prohibited this user from being saved:")
    end
    
  end

  context 'destroy user' do
    let!(:user) { User.create(email: 'aat@t.com', name: 'update test', password: '132123') }
    before(:each) do
      Capybara.current_driver = :selenium_chrome_headless
      login_as(user, scope: :user)
      visit edit_user_registration_path
    end

    scenario "should be sucessfull" do
      click_button "Cancel my account"
      accept_alert("Are you sure?")
  
      expect(page).to have_content "Bye! Your account has been successfully cancelled. We hope to see you again soon."
    end

    scenario 'should fail' do
      click_button "Cancel my account"
      page.driver.browser.switch_to.alert.dismiss
      expect(page).to have_content "Edit User"
    end
  end
end
