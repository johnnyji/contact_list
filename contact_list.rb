require './config'

class ContactList

  @@initial_command = ARGV[0]
  @@secondary_command = ARGV[1]
  @@tertiary_command = ARGV[2]

  def self.begin_app
    case @@initial_command
    when 'help' then show_directory
    when 'show' then validate_show_contact
    when 'find' then validate_find_contact
    when 'new' then prompt_and_create_contact
    when 'update' then prompt_for_update
    when 'list' then display_all_contacts
    else invalid_command
    end
  end

  private

  def self.display_all_contacts
    Contact.all.map { |contact| format_display(contact) }
  end

  def self.format_display(contact)
    "#{contact.id}: ".colorize(:white) + "#{contact.firstname} #{contact.lastname} ".colorize(:magenta) + "(#{contact.email})".colorize(:light_cyan) + " #{contact.phonenumbers.nil? ? 'No phone entered' : contact.phonenumbers}".colorize(:green)
  end

  def self.show_directory
    @@secondary_command.to_s.strip.empty? ? directory : invalid_command
  end

  def self.validate_show_contact
    return error('You must enter a valid ID to show') if @@secondary_command.to_s.strip.empty?
    return error('IDs must be positive (0 or greater)') if @@secondary_command.to_i < 0
    return error("#{@@secondary_command} is not a valid ID number!") if @@secondary_command.to_s.strip.match(/[^\d]/)
    contact = Contact.find(@@secondary_command.to_i)
    contact.is_a?(Contact) ? format_display(contact) : not_found_message('ID', @@secondary_command)
  end

  def self.validate_find_contact
    return error('You must enter a name to show') if @@secondary_command.to_s.strip.empty?
    return error('Please also provide a last name') if @@tertiary_command.to_s.strip.empty?
    return error("Theres no one with the name of #{@@secondary_command.capitalize} #{@@tertiary_command.capitalize}") if @@secondary_command.to_s.strip.match(/[^a-zA-Z]/)
    contact = Contact.find_by(firstname: @@secondary_command, lastname: @tertiary_command)
    contact.is_a?(Contact) ? format_display(contact) : not_found_message('name', @@secondary_command + ' ' + @@tertiary_command)
  end

  def self.prompt_and_create_contact
    first_name = prompt_user('First name: ')
    last_name = prompt_user('Last name:')
    email = prompt_user('Email: ')
    contact = Contact.create(firstname: first_name, lastname: last_name, email: email)
    contact.phones.prompt_for_numbers
  end

  # def self.prompt_for_update
  #   first_name = prompt_user('Full name: ')
  #   last_name = prompt_user('Last name: ')
  #   email = prompt_user('Email: ')
  #   phone_numbers = Phone.create_phone_numbers
  #   Contact.update(@@secondary_command, first_name, last_name, email, phone_numbers)
  # end

  def self.prompt_user(question)
    print question
    $stdin.gets.chomp
  end

  def self.directory
    puts 'Here is a list of avaliable commands:'.colorize(:magenta)
    puts '   new'.colorize(:light_cyan) + '    Create a new contact'
    puts '   update'.colorize(:light_cyan) + ' Updates a contact by ID'
    puts '   list'.colorize(:light_cyan) + '   List all contacts'
    puts '   show'.colorize(:light_cyan) + '   Show contact by ID'
    puts '   find'.colorize(:light_cyan) + '   Find contact by Index'
    puts '   edit'.colorize(:light_cyan) + '   Add phone number to contact'
  end

  def self.invalid_command
    'That was not a valid command'.colorize(:red)
  end

  def self.error(error)
    error.colorize(:red)
  end

  # def self.not_found_message(attribute, result)
  #   "Sorry, no one by the #{attribute} of #{result} found!".colorize(:red)
  # end

end

puts ContactList.begin_app