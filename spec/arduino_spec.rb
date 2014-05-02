require 'spec_helper'

describe Workshop::Arduino do
  context 'arduino app is at "/app" and the core is set to "arduino"' do
    let(:config) do
      double(:configuration).tap do |config|
        config.stub(:arduino_app_directory).and_return('/app')
        config.stub(:build_core).and_return('arduino')
      end
    end
    subject do
      Workshop::Arduino.new(config).tap do |arduino|
        arduino.stub(:hardware_path).and_return('/hardware')
      end
    end

    describe '#hardware_directory' do
      it 'returns "/app/hardware"' do
        expected = "/app/hardware"
        expect(subject.hardware_directory).to eq(expected)
      end
    end

    describe '#core_directory' do
      it 'returns "/app/hardware/arduino/cores/arduino"' do
        expected = "/app/hardware/arduino/cores/arduino"
        expect(subject.core_directory).to eq(expected)
      end
    end
  end
end
