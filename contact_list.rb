require './config'

class ContactList
  @@initial_command = ARGV[0]
  @@secondary_command = ARGV[1]

  def self.begin_app
    ContactDatabase.read_database
    case @@initial_command
    when 'help' then show_directory
    when 'show' then show_contact
    when 'find' then find_contact
    when 'new' then prompt_for_new_contact
    when 'list' then Contact.all
    else invalid_command
    end
  end

  private

  def self.show_directory
    @@secondary_command.to_s.strip.empty? ? directory : invalid_command
  end

  def self.show_contact
    return error('You must enter a valid ID to show') if @@secondary_command.to_s.strip.empty?
    return error('IDs must be positive (0 or greater)') if @@secondary_command.to_i < 0
    return error("#{@@secondary_command} is not a valid ID number!") if @@secondary_command.to_s.strip.match(/[^\d]/)
    Contact.show(@@secondary_command.to_i)
  end

  def self.find_contact
    return error('You must enter a name to show') if @@secondary_command.to_s.strip.empty?
    return error("Theres no one with the name of #{@@secondary_command.capitalize}") if @@secondary_command.to_s.strip.match(/[^a-zA-Z]/)
    Contact.find(@@secondary_command)
  end

  def self.prompt_for_new_contact
    name = prompt_user('Name: ')
    email = prompt_user('Email: ')
    Contact.new(name, email).create
  end

  def self.prompt_user(question)
    print question
    $stdin.gets.chomp
  end

  def self.directory
    puts 'Here is a list of avaliable commands:'.colorize(:magenta)
    puts '   new'.colorize(:light_cyan) + '  - Create a new contact'
    puts '   list'.colorize(:light_cyan) + ' - List all contacts'
    puts '   show'.colorize(:light_cyan) + ' - Show contact by ID'
    puts '   find'.colorize(:light_cyan) + ' - Find contact by Index'
  end

  def self.invalid_command
    'That was not a valid command'.colorize(:red)
  end

  def self.error(error)
    error.colorize(:red)
  end
end

puts ContactList.begin_app