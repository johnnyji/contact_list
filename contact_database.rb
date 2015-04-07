## TODO: Implement CSV reading/writing

class ContactDatabase

  def self.parse_contacts_from_csv
    csv = CSV.read('./contacts.csv')
    headers = csv.shift.map {|item| item.to_sym } #shift takes the first column into it's own array and maps each element to a symbol. [:id, :name, :email]
    data = csv.map {|row| row.map {|item| item.to_s } } #this maps each row and maps each element of the row to an array of it's own. ["id", Johnny", "johnny.ji@live.ca"]
    data.map {|row| Hash[*headers.zip(row).flatten] }
  end

  def self.format_contact_display(contact)
    "#{contact[:id]}: #{contact[:name].capitalize} (#{contact[:email]})"
  end

  def self.list
    self.parse_contacts_from_csv.each do |contact|
      puts self.format_contact_display(contact).colorize(:light_cyan)
    end
  end

  def self.search_by_id(id)
    found_contact = self.parse_contacts_from_csv.find { |contact| contact[:id] == id }
    puts found_contact.nil? ? "Sorry, no one by the ID of #{id} found!" : self.format_contact_display(found_contact).colorize(:green)
  end

end
