class Phone < ActiveRecord::Base
  belongs_to :contact

  def self.prompt_for_numbers
    phone_numbers = []
    add_phone = ContactList.prompt_user('Add phone? (y/n): ')
    while add_phone == 'y'
      type = ContactList.prompt_user('Add a phone type: ')
      number = ContactList.prompt_user('Add a number for that phone: ')
      phone_numbers << Phone.create(phonetype: type, number: number)
      add_phone = ContactList.prompt_user('Add phone? (y/n): ')
    end
  end

end