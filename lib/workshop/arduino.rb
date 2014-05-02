module Workshop
  class Arduino
    attr_accessor :config

    def initialize(config)
      self.config = config
    end

    def hardware_path
      '/Contents/Resources/Java/hardware'
    end

    def hardware_directory
      config.arduino_app_directory + hardware_path
    end

    def core_directory
      hardware_directory + '/arduino/cores/' + config.build_core
    end

    def variant_directory
      # TODO - find proper variant dir (could be in documents)
      if config.build_variant
        dir = hardware_directory + '/arduino/variants/' + config.build_variant
        if File.directory?(dir)
          dir
        else
          nil
        end

      end
    end
  end
end
