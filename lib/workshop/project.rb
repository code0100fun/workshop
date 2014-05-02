module Workshop
  class Project
    attr_accessor :config, :arduino, :builder, :uploader

    def self.configure(&block)
      new(&block)
    end

    def initialize(&block)
      self.config = Workshop::Project::Configuration.new
      block.call(config)
      self.arduino = Workshop::Arduino.new(config)
      self.builder = Workshop::Builder.new(self)
      self.uploader = Workshop::Uploader.new(self, builder.hex_file)
      Workshop::Tasks.new(builder, uploader)
    end

    def name
      config.project_name
    end

    def app_directory
      config.app_directory
    end

    def main_filename
      config.main_filename
    end

    def arduino_hardware_directory
      arduino.hardware_directory
    end

    def arduino_variant_directory
      arduino.variant_directory
    end

    def arduino_core_directory
      arduino.core_directory
    end

    def source_directory
      config.source_directory
    end

    def includes
      config.includes
    end

    def build_directory
      config.build_directory
    end

    def build_mcu
      config.build_mcu
    end

    def build_f_cpu
      config.build_f_cpu
    end

    def build_vid
      config.build_vid
    end

    def build_pid
      config.build_pid
    end

    def build_arduino
      # TODO - where does this come from?
      '105'
    end

    def programmer
      # TODO - read from boards.txt file
      config.upload_protocol
    end

    def com_port
      com_port_config['port']
    end

    def baud_rate
      # TODO - read from boards.txt file
      config.upload_speed
    end

    private

    def com_port_config
      YAML::load_file(File.join(app_directory, 'config/com_port.yml'))
    end

    def config=(config)
      @config = config
    end
  end
end
