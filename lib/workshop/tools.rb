module Workshop
  class Tools
    attr_accessor :hardware_directory

    def initialize(hardware_directory)
      self.hardware_directory = hardware_directory
    end

    def tools_directory
      hardware_directory + '/tools'
    end

    def bin_directory
      tools_directory + '/avr/bin'
    end

    def etc_directory
      tools_directory + '/avr/etc'
    end

    def avr_gcc
      bin_directory + '/avr-gcc'
    end

    def avr_gpp
      bin_directory + '/avr-g++'
    end

    def avr_ar
      bin_directory + '/avr-ar'
    end

    def avr_objcopy
      bin_directory + '/avr-objcopy'
    end

    def avrdude
      bin_directory + '/avrdude'
    end

    def avrdude_config
      etc_directory + '/avrdude.conf'
    end

    def compiler_for_extendion
      @_extension_map ||= {
        '.c' => avr_gcc,
        '.cpp' => avr_gpp
      }
    end

    def compiler(filename)
      compiler_for_extendion[File.extname(filename)]
    end
  end
end
