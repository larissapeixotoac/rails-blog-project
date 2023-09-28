require 'rails_helper'

RSpec.describe Author, type: :model do
  subject do 
    # author.new:
    described_class.new(
      name: "John Doe"
    )
  end

  it "is valid with valid attributes" do
    # subject should be a valid Author and should be instatiated
    expect(subject).to be_valid
  end

  it "is not valid when no name is entered" do
    subject.name = nil
    # i want this instantiation of subject to fail
    expect(subject).not_to be_valid
  end
end