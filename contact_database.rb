## TODO: Implement CSV reading/writing

class ContactDatabase

  def self.parse_contacts_from_csv
    csv = CSV.read('./contacts.csv')
    headers = csv.shift.map {|item| item.to_sym } #shift takes the first column into it's own array and maps each element to a symbol. [:id, :name, :email]
    data = csv.map {|row| row.map {|item| item.to_s } } #this maps each row and maps each element of the row to an array of it's own. ["id", Johnny", "johnny.ji@live.ca"]
    contacts = data.map {|row| Hash[*headers.zip(row).flatten] }
  end

  def self.list
    self.parse_contacts_from_csv.each do |contact|
      puts "#{contact[:id]}: #{contact[:name].capitalize} (#{contact[:email]})"
    end
  end

  def self.search_by_id(id)
    puts self.show(id) == [] ? "Sorry, no one by the ID of #{id} found!" : self.show(id)
  end

  def self.show(id)
    self.list.select { |contact| contact[:id] == id }
  end

end
