describe Contact do
  subject :contact do
    Contact.new("Johnny", "johnny.ji@live.ca")
  end

  it "should have a name" do
    expect(contact.name).to eq "Johnny"
  end
end