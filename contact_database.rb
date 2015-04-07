## TODO: Implement CSV reading/writing
require 'csv'
require 'pry'

class ContactDatabase

  def self.all
    csv = CSV.read('./contacts.csv')
    headers = csv.shift.map {|item| item.to_sym }
    data = csv.map {|row| row.map {|cell| cell.to_s } }
    array_of_hashes = data.map {|row| Hash[*headers.zip(row).flatten] }
  end

  def self.last
    self.all.last
  end
end

puts ContactDatabase.last
