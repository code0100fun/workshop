require 'spec_helper'

describe Workshop::Builder do
  let(:project_name) {'foo'}
  let(:main_filename) {nil}
  let(:arduino_hardware_directory) {'/app/hardware'}
  let(:arduino_variant_directory) {'/app/hardware/variants/standard'}
  let(:arduino_core_directory) {'/app/hardware/cores/arduino'}
  let(:source_directory) {'/app/src'}
  let(:build_directory) {'/app/build'}
  let(:build_mcu) {'atmega32u4'}
  let(:build_f_cpu) {'16000000L'}
  let(:build_vid) {'0x0000'}
  let(:build_pid) {'0x0001'}
  let(:build_arduino) {'111'}
  let(:project) do
    double(:project).tap do |project|
      project.stub(:arduino_hardware_directory).and_return(arduino_hardware_directory)
      project.stub(:arduino_core_directory).and_return(arduino_core_directory)
      project.stub(:arduino_variant_directory).and_return(arduino_variant_directory)
      project.stub(:source_directory).and_return(source_directory)
      project.stub(:build_directory).and_return(build_directory)
      project.stub(:build_mcu).and_return(build_mcu)
      project.stub(:build_f_cpu).and_return(build_f_cpu)
      project.stub(:build_vid).and_return(build_vid)
      project.stub(:build_pid).and_return(build_pid)
      project.stub(:build_arduino).and_return(build_arduino)
      project.stub(:name).and_return(project_name)
      project.stub(:main_filename).and_return(main_filename)
    end
  end
  subject do
    Workshop::Builder.new(project).tap do |builder|
      Dir.stub(:[]).with("#{arduino_core_directory}/**/*.c").and_return([
        "#{arduino_core_directory}/core.c"])
      Dir.stub(:[]).with("#{arduino_core_directory}/**/*.cpp").and_return([
        "#{arduino_core_directory}/core.cpp"])
      Dir.stub(:[]).with("#{arduino_variant_directory}/**/*.c").and_return([
        "#{arduino_variant_directory}/variant.c"])
      Dir.stub(:[]).with("#{arduino_variant_directory}/**/*.cpp").and_return([
        "#{arduino_variant_directory}/variant.cpp"])
      Dir.stub(:[]).with("#{source_directory}/**/*.c").and_return([
        "#{source_directory}/app.c"])
      Dir.stub(:[]).with("#{source_directory}/**/*.cpp").and_return([
        "#{source_directory}/app.cpp"])
    end
  end

  describe '#core_files' do
    it 'it returns the c and cpp files in the "arduino" core directory' do
      files = subject.core_files
      expect(files).to eq(['/app/hardware/cores/arduino/core.c',
                            '/app/hardware/cores/arduino/core.cpp'])
    end
  end

  describe '#variant_files' do
    it 'it returns the c and cpp files in the "standard" variant directory' do
      files = subject.variant_files
      expect(files).to eq(['/app/hardware/variants/standard/variant.c',
                            '/app/hardware/variants/standard/variant.cpp'])
    end
  end

  describe '#source_files' do
    it 'it returns the c and cpp files in the project source directory' do
      files = subject.source_files
      expect(files).to eq(['/app/src/app.c', '/app/src/app.cpp'])
    end
  end

  describe '#output_file' do
    it 'for "/app/src/foo.c" it returns "/app/build/foo.c.o"' do
      output = subject.output_file('/app/src/foo.c')
      expect(output).to eq('/app/build/foo.c.o')
    end
  end

  describe '#o_files_to_archive' do
    context 'project name is the same as the main output file' do
      let(:project_name) {'foo'}
      it 'the *.o files to archive do not include the "foo.cpp.o" file' do
        files = subject.o_files_to_archive
        expect(files).to_not include('/app/build/foo.cpp.o')
      end
    end
  end

  describe '#compiler_flags' do
    context 'build options have values' do
      it 'returns the correct compiler flags for a *.c file' do
        flags = subject.compiler_flags
        expect(flags).to include('-c')
        expect(flags).to include('-g')
        expect(flags).to include('-Os')
        expect(flags).to include('-Wall')
        expect(flags).to include('-fno-exceptions')
        expect(flags).to include('-ffunction-sections')
        expect(flags).to include('-fdata-sections')
        expect(flags).to include('-mmcu=atmega32u4')
        expect(flags).to include('-DF_CPU=16000000L')
        expect(flags).to include('-MMD')
        expect(flags).to include('-DUSB_VID=0x0000')
        expect(flags).to include('-DUSB_PID=0x0001')
        expect(flags).to include('-DARDUINO=111')
      end
    end

    context 'build options are nil' do
      let(:build_mcu) {nil}
      let(:build_f_cpu) {nil}
      let(:build_vid) {nil}
      let(:build_pid) {nil}
      let(:build_arduino) {nil}
      it 'returns the correct compiler flags for a *.c file' do
        flags = subject.compiler_flags
        expect(flags).to include('-c')
        expect(flags).to include('-g')
        expect(flags).to include('-Os')
        expect(flags).to include('-Wall')
        expect(flags).to include('-fno-exceptions')
        expect(flags).to include('-ffunction-sections')
        expect(flags).to include('-fdata-sections')
        expect(flags).to_not include('-mmcu=')
        expect(flags).to_not include('-DF_CPU=')
        expect(flags).to include('-MMD')
        expect(flags).to_not include('-DUSB_VID=')
        expect(flags).to_not include('-DUSB_PID=')
        expect(flags).to_not include('-DARDUINO=')
      end
    end
  end

  describe '#compile_command_for' do
    it 'constructs a avr-gcc compile command for a *.c file' do
      command = subject.compile_command_for('/app/src/foo.c')
      expect(command).to include('/app/hardware/tools/avr/bin/avr-gcc')
      expect(command).to include('-c')
      expect(command).to include('-g')
      expect(command).to include('-Os')
      expect(command).to include('-Wall')
      expect(command).to include('-fno-exceptions')
      expect(command).to include('-ffunction-sections')
      expect(command).to include('-fdata-sections')
      expect(command).to include('-mmcu=atmega32u4')
      expect(command).to include('-DF_CPU=16000000L')
      expect(command).to include('-MMD')
      expect(command).to include('-DUSB_VID=0x0000')
      expect(command).to include('-DUSB_PID=0x0001')
      expect(command).to include('-DARDUINO=111')
      expect(command).to include('/app/src/foo.c')
      expect(command).to include('-I/app/hardware/cores/arduino')
      expect(command).to include('-I/app/hardware/variants/standard')
      expect(command).to include('-o /app/build/foo.c.o')
    end
  end

end
