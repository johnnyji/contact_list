require 'pg'

class ORM
  def initialize
    @connection = PG.connect(dbname: @db_name)
  end

  def find
    @connection.exec("SELECT * FROM #{@table} WHERE id=? LIMIT 1", id)
  end

  def find_by(params)
    @connection.exec("SELECT * FROM #{@table} WHERE #{build_params(params)} LIMIT 1")
  end

  def where(params)
    query_string = params.is_a?(Hash) ? build_params(params) : params
    @connection.exec("SELECT * FROM #{@table} WHERE #{query_string}")
  end

  def destroy(id)
    @connection.execute("DELETE FROM #{@table} WHERE id=?", id)
  end

  def save
    @id.nil? ? create : update
  end

  def create
    @connection.exec("INSERT INTO #{@table} (#{params}.keys.join(', ') VALUES #{params.values.join(', ')})")
  end

  def update
  end

  private

  def build_params(params)
    params.keys.map { |key| "#{key.to_s}='#{params[key]}'" }.join(' AND ')
  end
end