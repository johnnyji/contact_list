require 'pg'
require 'pry'
require 'colorize'

class Contact
  attr_reader :id, :first_name, :last_name, :email, :phone_numbers
 
  def initialize(id=nil, first_name, last_name, email, phone_numbers)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone_numbers = phone_numbers
  end

  def create
    new_contact = Contact.connection.exec("INSERT INTO contacts (firstname, lastname, email, phonenumbers) VALUES ('#{@first_name}', '#{@last_name}', '#{@email}', '#{@phone_numbers}') RETURNING *")
    'Thanks for the addition!'.colorize(:green)
  end

  ########## CLASS METHODS ##########

  def self.connection
    PG.connect(
      dbname: 'd96rfcutpr7g5e',
      port: 5432,
      user: 'rpdpzqtjsmvnbv',
      host: 'ec2-54-163-225-82.compute-1.amazonaws.com',
      password: 'cvuaKUHlD4wJ68QnHucjBNqQyx'
    )
  end

  def self.update(id, first_name, last_name, email, phone_numbers)
    Contact.connection.exec("UPDATE contacts SET firstname='#{first_name}',lastname='#{last_name}', email='#{email}', phonenumbers='#{phone_numbers}' WHERE id = '#{id.to_i}'")
    "Thanks! We've updated them for you.".colorize(:green)
  end

  def self.all #show all contacts
    connection.exec("SELECT * FROM contacts").map { |contact| instantiate_contact(contact) }
  end

  def self.show_by_id(index) #find contact by ID
    contact = connection.exec("SELECT * FROM contacts WHERE id = '#{index.to_s}'").first
    instantiate_contact(contact) unless contact.nil?
  end

  def self.find_all_by_first_name(first_name)
    connection.exec("SELECT * FROM contacts WHERE firstname = '#{first_name}'").map { |contact| instantiate_contact(contact) }
  end

  def self.find_all_by_last_name(last_name)
    connection.exec("SELECT * FROM contacts WHERE lastname = '#{last_name}'").map { |contact| instantiate_contact(contact) }
  end

  def self.find_by_email(email)
    connection.exec("SELECT * FROM contacts WHERE email = '#{email}'").map { |contact|
      instantiate_contact(contact) }
  end
  
  def self.find_by_name(first_name, last_name) #find contact by name
    contact = connection.exec("SELECT * FROM contacts WHERE firstname = '#{first_name}' AND lastname = '#{last_name}'").first
    instantiate_contact(contact) unless contact.nil?
  end

  private

  def self.not_found_message(attribute, result)
    "Sorry, no one by the #{attribute} of #{result} found!".colorize(:red)
  end

  def self.instantiate_contact(contact)
    Contact.new(contact['id'], contact['firstname'], contact['lastname'], contact['email'], contact['phonenumbers'])
  end
end
