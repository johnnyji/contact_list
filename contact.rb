require 'pg'
require 'pry'
require 'colorize'

class Contact
  attr_reader :name, :email, :phone_numbers
  attr_accessor :id
 
  def initialize(id, name, email, phone_numbers=[])
    @id = id
    @name = name
    @email = email
    @phone_numbers = phone_numbers
  end

  def create
    if existing_contact.nil?
      CSV.open('./contacts.csv', 'a') { |csv| csv << [@name,@email,@phone_numbers] }
      "Contact successfully created!".colorize(:green)
    else
      puts "#{@email} already exists!".colorize(:red)
      ContactList.prompt_for_new_contact
    end
  end

  def existing_contact
    ContactDatabase.list.find { |contact| contact.email == @email }
  end
  
  ##### CLASS METHODS #####

  def self.connection
    PG.connect(
      dbname: 'd96rfcutpr7g5e',
      port: 5432,
      user: 'rpdpzqtjsmvnbv',
      host: 'ec2-54-163-225-82.compute-1.amazonaws.com',
      password: 'cvuaKUHlD4wJ68QnHucjBNqQyx'
    )
  end

  def self.all
    connection.exec("SELECT * FROM contacts").map do |contact|
      format_display(contact)
    end
  end

  def self.show_by_id(index)
    contact = connection.exec("SELECT * FROM contacts WHERE id = '#{index.to_s}'").first
    contact.nil? ? not_found_message('ID', index) : format_display(contact)
  end
  
  def self.find_by_name(first_name, last_name)
    contact = connection.exec("SELECT * FROM contacts WHERE firstname = '#{first_name}' AND lastname = '#{last_name}'")
    contact.nil? ? not_found_message('name', first_name) : format_display(contact)
  end

  private

  def self.not_found_message(attribute, result)
    "Sorry, no one by the #{attribute} of #{result} found!".colorize(:red)
  end

  def self.format_display(contact)
     c = instantiate_contact(contact)
    "#{c.id}: #{c.name} (#{c.email}) #{ct.phone_numbers unless c.phone_numbers.empty?}".colorize(:green)
  end

  def self.instantiate_contact(contact)
    Contact.new(contact['id'], "#{contact['firstname'] + contact['lastname']}", contact['email'])
  end
end

puts Contact.find_by_name('Johnny', 'Ji')