module Workshop
  class Uploader
    include FileUtils
    attr_accessor :project, :tools, :hex_filename

    def initialize(project, hex_filename)
      self.project = project
      self.tools = Workshop::Tools.new project.arduino_hardware_directory
      self.hex_filename = hex_filename
    end

    def com_port
      project.com_port
    end

    def upload_command
      [
        tools.avrdude,
        "-C #{tools.avrdude_config}",
        "-v -v -v -v -v -v",
        "-p #{project.build_mcu}",
        "-c #{project.programmer}",
        "-P #{project.com_port}",
        "-b #{project.baud_rate}",
        "-D",
        "-Uflash:w:#{hex_filename}:i"
      ].join(' ')
    end

    def upload
      sh upload_command
    end

  end
end
