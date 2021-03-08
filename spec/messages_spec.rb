require_relative '../lib/messages'

describe Messages do
  let(:messages) { Messages.new }

  context '#helper' do
  it 'help_command parse to a Stringand sent to the BOT to display' do
    expect(test_commands.helper.class).to eq(String)
  end

  it 'help_command parse should not parse to an Integer' do
    expect(test_commands.helper.class).not_to eq(Integer)
  end

  it 'help_command variable is not NULL' do
    expect(test_commands.helper).not_to eq(nil)
  end
end