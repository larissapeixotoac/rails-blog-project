module AuthenticationHelpers
  def login(email, name, password)
    user = User.create(email: email, name: name, password: password)
    visit new_user_session_path
      within('form') do
          fill_in "Email", with: user.email
          fill_in 'Password', with: user.password
        end
      click_button('commit')
      expect(page).to have_content('Signed in successfully.')
  end
end