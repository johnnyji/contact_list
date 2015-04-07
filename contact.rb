class Contact
  attr_reader :name, :email
 
  def initialize(name, email)
    @name = name
    @email = email
  end

  def create
    CSV.open('./contacts.csv', 'a') do |csv|
      csv << [@name,@email]
    end
    "Contact successfully created!".colorize(:green)
  end 
  
  ##### CLASS METHODS #####

  def self.all
    ContactDatabase.list.each_with_index.map do |contact, index|
      format_display(index, contact).colorize(:light_cyan)
    end
  end

  def self.show(index)
    contact = ContactDatabase.list[index].nil? ? not_found_message('ID', index) : ContactDatabase.list[index]
    format_display(ContactDatabase.list.index(contact), contact)
  end
  
  def self.find(name)
    contact = ContactDatabase.list.find { |contact| contact.name.downcase == name.downcase }
    contact.nil? ? not_found_message('name', name) : format_display(ContactDatabase.list.index(contact), contact).colorize(:green)
  end

  private

  def increment_id
    last_contact_id = ContactDatabase.parse_csv.last[:id].to_i
    last_contact_id + 1
  end

  def self.not_found_message(attribute, number)
    "Sorry, no one by the #{attribute} of #{number} found!".colorize(:red)
  end

  def self.format_display(index, contact)
    "#{index}: #{contact.name} (#{contact.email})".colorize(:green)
  end

end