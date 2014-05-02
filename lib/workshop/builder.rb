module Workshop
  class Builder
    include FileUtils
    attr_accessor :project, :tools

    def initialize(project)
      self.project = project
      self.tools = Workshop::Tools.new project.arduino_hardware_directory
    end

    def main_name
      project.name.parameterize.underscore
    end

    def main_filename
      if project.main_filename
        project.app_directory + '/' + project.main_filename
      else
        source_files.first
      end
    end

    def create_build_directory
      Dir.mkdir(project.build_directory) unless Dir.exists?(project.build_directory)
    end

    def clean
      FileUtils.rm_rf(project.build_directory)
    end

    def core_files
      code_files_in_directory project.arduino_core_directory
    end

    def variant_files
      code_files_in_directory(project.arduino_variant_directory)
    end

    def source_files
      code_files_in_directory project.source_directory
    end

    def all_source_files
      core_files + variant_files + source_files
    end

    def compile_command_for(filename)
      [
        tools.compiler(filename),
        compiler_flags,
        include_flags,
        filename,
        "-o #{output_file(filename)}"
      ].join(' ')
    end

    def archive_command_for(filename)
      [
        tools.avr_ar,
        'rcs',
        archive_file,
        filename,
      ].join(' ')
    end

    def compile
      all_source_files.each do |filename|
        sh compile_command_for(filename)
      end
    end

    def o_files_to_archive
      all_source_files.reject do |filename|
        filename == main_output_file
      end.map { |filename| output_file(filename) }
    end

    def archive
      o_files_to_archive.each do |filename|
        sh archive_command_for(filename)
      end
    end

    def output_file(filename)
      project.build_directory + '/' + File.basename(filename) + '.o'
    end

    def main_output_file
      project.build_directory + '/' + File.basename(main_filename) + '.o'
    end

    def archive_file
      project.build_directory + '/core.a'
    end

    def elf_file
      project.build_directory + '/' + main_name + '.elf'
    end

    def eeprom_file
      project.build_directory + '/' + main_name + '.eep'
    end

    def hex_file
      project.build_directory + '/' + main_name + '.hex'
    end

    def linker_flags
      [
        '-Os',
        '-Wl,--gc-sections',
        "-mmcu=#{project.build_mcu}"
      ].join(' ')
    end

    def link_command
      [
        tools.avr_gcc,
        linker_flags,
        "-o #{elf_file}",
        main_output_file,
        archive_file,
        "-L #{project.build_directory}",
        '-lm'
      ].join(' ')
    end

    def link
      sh link_command
    end

    def eeprom_command
      [
        tools.avr_objcopy,
        eeprom_flags,
        elf_file,
        eeprom_file,
      ].join(' ')
    end

    def create_eeprom
      sh eeprom_command
    end

    def hex_command
      [
        tools.avr_objcopy,
        hex_flags,
        elf_file,
        hex_file,
      ].join(' ')
    end

    def create_hex
      sh hex_command
    end

    def compiler_flags
      [
        '-c',
        '-g',
        '-Os',
        '-Wall',
        '-fno-exceptions',
        '-ffunction-sections',
        '-fdata-sections',
        ("-mmcu=#{project.build_mcu}" if project.build_mcu),
        ("-DF_CPU=#{project.build_f_cpu}" if project.build_f_cpu),
        '-MMD',
        ("-DUSB_VID=#{project.build_vid}" if project.build_vid),
        ("-DUSB_PID=#{project.build_pid}" if project.build_pid),
        ("-DARDUINO=#{project.build_arduino}" if project.build_arduino)
      ].join(' ')
    end

    def include_flags
      include_directories.compact.map { |include| "-I#{File.expand_path(include)}"}.join(' ')
    end

    def include_directories
      [project.arduino_core_directory, project.arduino_variant_directory] + project.includes
    end

    def eeprom_flags
      '-O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0'
    end

    def hex_flags
      '-O ihex -R .eeprom'
    end

    def code_files_in_directory(directory)
      return [] unless directory
      Dir[directory + '/**/*.c'] +
      Dir[directory + '/**/*.cpp']
    end

  end
end
