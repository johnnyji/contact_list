class FakeStdout
  attr_reader :messages
  def initialize
    @messages = []
  end
  def write(*args)
    @messages << args.first
  end
  def print(*args)
    @messages << args.first
  end

  def tty?
    return false
  end

  def clear
    @messages = []
  end
end