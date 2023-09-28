require 'rails_helper'
# Tests in what it has on an page
RSpec.describe "books/index", type: :view do
  before(:each) do
    @authorOne = Author.create!(
        name: "John Doe"
    )
    @authorTwo = Author.create!(
        name: "Jane Wail"
    )

    assign(:books, [
      Book.create!(
        title: "Terrible Title",
        author_id: @authorTwo.id
      ),
      Book.create!(
        title: "Just Wait!",
        author_id: @authorOne.id
      )
    ])
  end

  it "renders a list of books" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Terrible Title".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Just Wait!".to_s), count: 1
    assert_select cell_selector, text: Regexp.new(@authorOne.id.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(@authorTwo.id.to_s), count: 1

  end
end