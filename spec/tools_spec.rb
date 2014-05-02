require 'spec_helper'

describe Workshop::Tools do
  context 'arduino hardware directory is "/app/hardware"' do
    let(:hardware_directory) { '/app/hardware' }
    subject { Workshop::Tools.new hardware_directory }

    describe '#tools_directory' do
      it 'returns "/app/hardware/tools"' do
        expect(subject.tools_directory).to eq('/app/hardware/tools')
      end
    end

    describe '#avr_gcc' do
      it 'returns "/app/hardware/tools/avr-gcc"' do
        expect(subject.avr_gcc).to eq('/app/hardware/tools/avr/bin/avr-gcc')
      end
    end

    describe '#compiler' do
      it 'returns "avr-gcc" for a *.c file' do
        compiler = subject.compiler('/app/src/foo.c')
        expect(compiler).to eq('/app/hardware/tools/avr/bin/avr-gcc')
      end

      it 'returns "avr-g++" for a *.cpp file' do
        compiler = subject.compiler('/app/src/foo.cpp')
        expect(compiler).to eq('/app/hardware/tools/avr/bin/avr-g++')
      end
    end

  end
end
