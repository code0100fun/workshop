module Workshop
  class Project
    class Configuration
      class Build
        attr_accessor :mcu, :core, :variant, :f_cpu, :vid, :pid, :libraries, :includes

        def initialize
          self.mcu = 'atmega328p'
          self.core = 'arduino'
          self.variant = 'standard'
          self.f_cpu = '8000000L'
          self.libraries = []
          self.includes = []
        end
      end
    end
  end
end
