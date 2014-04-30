require 'spec_helper'

describe Workshop::Project do
  describe 'configure' do
    it 'passes a configure parameter' do
      Workshop::Project.configure do |config|
        expect(config.class).to eq(Workshop::Project::Configuration)
      end
    end
  end
end
