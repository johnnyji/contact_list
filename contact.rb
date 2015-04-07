require 'csv'
require 'pry'
require './contact_database'

class Contact
 
  attr_accessor :name, :email
 
  def initialize(name, email)
    @name = name
    @email = email
  end
 
  def to_s
    # TODO: return string representation of Contact
  end
 
  ## Class Methods
  def self.create(name, email)

    # TODO: Will initialize a contact as well as add it to the list of contacts
    CSV.open('./contacts.csv', 'a') do |csv|
      csv << [increment_id,name,email]
    end
  end

  def self.increment_id
    last_contact_id = ContactDatabase.last[:id].to_i
    last_contact_id + 1
  end

  def self.find(index)
    # TODO: Will find and return contact by index
  end

  def self.all
    # TODO: Return the list of contacts, as is
  end
  
  def self.show(id)
    # TODO: Show a contact, based on ID
  end
end

Contact.create("Jerry", "haha")