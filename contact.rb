class Contact
  attr_reader :name, :email
  attr_accessor :phone_type, :phone_number
 
  def initialize(name, email, phone_type=nil ,phone_number=nil)
    @name = name
    @email = email
    @phone_type = phone_type
    @phone_number = phone_number
  end

  def create
    existing_contact = ContactDatabase.list.find { |contact| contact.email == @email }
    if existing_contact.nil?
      CSV.open('./contacts.csv', 'a') do |csv|
        csv << [@name,@email]
      end
      "Contact successfully created!".colorize(:green)
    else
      puts "#{@email} already exists!".colorize(:red)
      ContactList.prompt_for_new_contact
    end
  end 
  
  ##### CLASS METHODS #####

  def self.add_phone_number(contact)
    contact = ContactDatabase.retrieve_contact(contact)
    CSV.open('./contacts.csv', 'a').find do |csv|
      csv[2] == contact.email
    end
  end

  def self.all
    ContactDatabase.list.each_with_index.map do |contact, index|
      format_display(index, contact).colorize(:light_cyan)
    end
  end

  def self.show(index)
    contact = ContactDatabase.list[index]
    contact.nil? ? not_found_message('ID', index) : format_display(ContactDatabase.list.index(contact), contact)
  end
  
  def self.find(name)
    contact = ContactDatabase.retrieve_contact(name)
    contact.nil? ? not_found_message('name', name) : format_display(ContactDatabase.list.index(contact), contact).colorize(:green)
    binding.pry
  end

  private

  def self.not_found_message(attribute, number)
    "Sorry, no one by the #{attribute} of #{number} found!".colorize(:red)
  end

  def self.format_display(index, contact)
    "#{index}: #{contact.name} (#{contact.email})".colorize(:green)
  end

end