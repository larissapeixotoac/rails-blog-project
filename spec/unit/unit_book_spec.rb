require 'rails_helper'

RSpec.describe Book, type: :model do
  # create an author to use in test cases
  before(:each) do
    @author = Author.create!(
      name: "John Doe"
    )
  end

  subject do 
    described_class.new(
      title: "This is a Terribel Book",
      author_id: @author.id
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid when no title is entered" do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it "is not valid when no author_id is given" do
    subject.author_id = nil
    expect(subject).not_to be_valid
  end

  it "is not valid when invalid auhtor_id is given" do
    subject.author_id = @author.id + 100
    expect(subject).not_to be_valid
  end

end