class Phone
  attr_reader :type, :number
  def initialize(type, number)
    @type = type
    @number = number
  end

  def self.create_phone_numbers
    phone_numbers = []
    add_phone = prompt_user('Add phone? (y/n): ')
    while add_phone == 'y'
      type = prompt_user('Add a phone type: ')
      number = prompt_user('Add a number for that phone: ')
      phone_numbers << Phone.new(type, number)
      add_phone = prompt_user('Add phone? (y/n): ')
    end
    numbers_array = phone_numbers.map do |phone|
      "#{phone.type}: #{phone.number}"
    end
    numbers_array.join(", ")
  end

  def self.prompt_user(question)
    print question
    $stdin.gets.chomp
  end
end