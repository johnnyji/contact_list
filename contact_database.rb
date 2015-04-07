## TODO: Implement CSV reading/writing

class ContactDatabase

  @@contact_list = []

  def self.list
    @@contact_list
  end

  def self.read_database
    CSV.read('./contacts.csv', 'r').map do |contact|
      @@contact_list << Contact.new(contact[1], contact[2])
    end
  end

  private

  def initialize
    raise 'You cannot instatiate a static class.'
  end

end