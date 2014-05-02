module Workshop
  class Project
    class Configuration
      class Upload
        attr_accessor :protocol, :speed, :includes

        def initialize
          self.protocol = 'stk500'
          self.speed = 57600
          self.includes = []
        end
      end
    end
  end
end
