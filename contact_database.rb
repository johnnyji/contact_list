## TODO: Implement CSV reading/writing

class ContactDatabase

  @@contact_list = []

  def self.list
    @@contact_list
  end

  def self.retrieve_contact(name)
    @@contact_list.find {|contact| contact.name.downcase == name.to_s.downcase}
  end

  def self.read_database
    CSV.read('./contacts.csv').map do |contact|
      @@contact_list << Contact.new(contact[0], contact[1], contact[2])
    end
  end

  private

  def initialize
    raise 'You cannot instatiate a static class.'
  end

end