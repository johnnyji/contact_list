require 'spec_helper'


describe Application do
  describe '#execute' do
    it 'returns help screen when input is "help"' do
      # prep
      @app = Application.new
      expect($stdin).to receive_message_chain('gets.chomp').and_return("unicorns!")
      # $stdin.gets.chomp
      # => unicorns!

      expect {
        @app.execute  
      }.to output("unicorns!\nfoo\n").to_stdout
    end
  end
end