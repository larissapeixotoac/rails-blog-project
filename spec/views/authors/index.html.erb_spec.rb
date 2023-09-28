require 'rails_helper'

RSpec.describe "authors/index", type: :view do
  before(:each) do
    assign(:authors, [
      Author.create!(
        name: "John Doe"
      ),
      Author.create!(
        name: "Jane Wail"
      )
    ])
  end

  it "renders a list of authors" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("John Doe".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Jane Wail".to_s), count: 1
  end

  it "renders a show button for each author" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Show".to_s), count: 2
  end
end