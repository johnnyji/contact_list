class Phone < ActiveRecord::Base
  belongs_to :contact

  def self.prompt_for_numbers
    phone_numbers = []
    add_phone = ContactList.prompt_user('Add phone? (y/n): ')
    while add_phone == 'y'
      type = ContactList.prompt_user('Add a phone type: ')
      number = ContactList.prompt_user('Add a number for that phone: ')
      phone_numbers << Phone.new(phonetype: type, number: number)
      add_phone = ContactList.prompt_user('Add phone? (y/n): ')
    end
    phone_numbers.each { |phone| phone.save }
  end

end