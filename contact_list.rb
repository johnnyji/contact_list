require './config'

class ContactList

  def self.begin_app
    initial_command = ARGV.first
    secondary_command = ARGV[1]

    case initial_command
    when 'show' then ContactDatabase.search_by_id(secondary_command)
    when 'find' then #find by index
    when 'new' then prompt_for_new_contact
    when 'list' then ContactDatabase.list
    else display_error_message
    end
  end

  private

  def self.display_error_message
    puts 'That was not a valid command'
  end

  def self.prompt_for_new_contact
    name = prompt_user('Name: ')
    email = prompt_user('Email: ')
    Contact.create(name, email)
  end

  def self.prompt_user(question)
    print question
    $stdin.gets.chomp
  end
end

ContactList.begin_app