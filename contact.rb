class Contact
  attr_reader :name, :email
 
  def initialize(name, email)
    @name = name
    @email = email
  end
 
  ## Class Methods
  def self.create(name, email)
    CSV.open('./contacts.csv', 'a') do |csv|
      csv << [increment_id,name,email]
    end
  end

  def self.find(index)
    # TODO: Will find and return contact by index
  end
  
  def self.show(id)
    # TODO: Show a contact, based on ID
  end

  private

  def self.increment_id
    last_contact_id = ContactDatabase.list.last[:id].to_i
    last_contact_id + 1
  end

end