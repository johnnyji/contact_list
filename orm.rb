require 'pry'
class ORM
  def save
    @id.nil? ? create : update
  end

  def create
    database = "#{self.class.downcase}s"
    binding.pry
    create = "INSERT INTO #{database} () VALUES ()"
    $connection 
  end

  def update
  end
end