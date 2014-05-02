require 'spec_helper'

describe Workshop::Project do
  let(:arduino) do
    double(:arduino).tap do |arduino|
      arduino.stub(:hardware_directory).and_return('/hardware')
    end
  end

  subject do
    Workshop::Project.configure { |config| }.tap do |project|
      project.stub(:arduino).and_return(arduino)
    end
  end

  describe 'configure' do
    it 'passes a configure parameter' do
      Workshop::Project.configure do |config|
        expect(config.class).to eq(Workshop::Project::Configuration)
      end
    end
  end

  describe '#arduino_hardware_directory' do
    it 'returns the arduino configs hardware directory' do
      expect(subject.arduino_hardware_directory).to eq('/hardware')
    end
  end
end
