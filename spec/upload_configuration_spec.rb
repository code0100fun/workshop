require 'spec_helper'

describe Workshop::Project::Configuration::Upload do
  describe '#protocol' do
    it 'returns "stk500" as the default protocol' do
      expect(subject.protocol).to eq('stk500')
    end
  end
end
