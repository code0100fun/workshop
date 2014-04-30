require 'spec_helper'

describe Workshop::Project::Configuration do
  describe 'initialize' do
    it 'defaults arduiono app directory to standard OS X app location' do
      config = Workshop::Project::Configuration.new
      expect(config.arduino_app_directory).to eq('/Applications/Arduino.app')
    end
  end
end
