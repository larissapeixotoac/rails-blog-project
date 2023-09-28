require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  context 'create new post' do
    let(:user){ User.create(email: 'psss@p.com', name: 'posted', password: '123123') }
    before(:each) do
      login_as(user, scope: :user)
      visit posts_path
      click_link("New post")
      fill_in 'Title', with: 'New posst'
    end

    scenario "should be successful" do
      fill_in "Body", with: 'blablabla'
      click_button("Create Post")
      expect(page).to have_content("successful")
    end

    scenario 'shoud fail' do
      click_button("Create Post")
      expect(page).to have_content("Body can't be blank")
    end
  end

  context 'edit post' do
    let(:user){ User.create(email: 'psss@p.com', name: 'posted', password: '123123') }
    before(:each) do
      login_as(user, scope: :user)
      newPost = Post.create(user_id: user.id, title: 'new one', body: 'test body!')
      visit edit_post_path(newPost.id)
    end

    scenario 'sould be successful' do      
      fill_in 'Title', with: 'Changed Title'
      click_button('Update Post')
      expect(page).to have_content('successful')
    end

    scenario 'on blank title: sould fail' do
      fill_in "Title", with: ''
      click_button('Update Post')
      expect(page).to have_content('Title can\'t be blank')
    end

    scenario 'on blank body: sould fail' do
      fill_in "Body", with: ''
      click_button('Update Post')
      expect(page).to have_content('Body can\'t be blank')
    end
  end

  context 'destroy post' do
    let(:user){ User.create(email: 'psss@p.com', name: 'posted', password: '123123') }
    before(:each) do
      login_as(user, scope: :user)
      newPost = Post.create(user_id: user.id, title: 'new one', body: 'test body!')
      visit post_path(newPost.id)
    end

    scenario 'should be successful' do
      click_button('Destroy this post')
      expect(page).to have_content('successfully')
    end

    scenario 'should be successful' do
      click_button('Destroy this post')
      expect(page).to have_content('successfully')
    end
  end
end