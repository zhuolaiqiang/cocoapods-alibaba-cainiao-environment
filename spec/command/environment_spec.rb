require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Environment do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ environment }).should.be.instance_of Command::Environment
      end
    end
  end
end

