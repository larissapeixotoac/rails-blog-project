require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @author = Author.create!(name: "John Doe")
    @book = books(:one)    
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "Books"
  end

  test "should create book" do
    visit books_url
    click_on "New book"

    fill_in "Title", with: @book.title
    fill_in "Author", with: @author.id
    click_on "Create Book"

    assert_text "Book was successfully created"
    click_on "Back"
  end

  test "should not create book given an author_id invalid" do
    visit books_url
    click_on "New book"

    fill_in "Title", with: @book.title
    fill_in "Author", with: @author.id + 100
    click_on "Create Book"

    assert_text "Author must exist"
  end

  test "should update Book" do
    visit book_url(@book)
    click_on "Edit this book", match: :first

    fill_in "Title", with: @book.title + " Perfect"
    fill_in "Author", with: @author.id
    click_on "Update Book"

    assert_text "Book was successfully updated"
    click_on "Back"
  end

  test "should not update Book with a nill title" do
    visit book_url(@book)
    click_on "Edit this book", match: :first

    fill_in "Title", with: nil
    fill_in "Author", with: @author.id
    click_on "Update Book"

    assert_text "Title can't be blank"
  end

  test "should destroy Book" do
    visit book_url(@book)
    click_on "Destroy this book", match: :first

    assert_text "Book was successfully destroyed"
  end
end
