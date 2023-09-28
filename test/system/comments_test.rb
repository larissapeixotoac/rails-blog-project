require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase

  test 'create a comment' do
      # Visit the post page
    visit post_path(posts(:testyboy))
    
      # Fill in the comment form
    fill_in "Body", with: "This is a comment"
    
      # Submit the form
    click_on "Create Comment"

      # Assert that comment was created
    assert_text "Comment was successfully created."
  end

  test 'create comment, destroy a post and go back to home' do
    visit post_path(posts(:two))
    fill_in "Body", with: "This is a comment of a test"
    click_on "Create Comment"
    assert_text "Comment was successfully created."
    click_on "Back to posts"
    visit post_path(posts(:testyboy))
    click_on "Destroy this post"
    assert_text "Post was successfully destroyed."
    visit root_path
  end
end