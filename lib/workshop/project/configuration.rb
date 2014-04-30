module Workshop
  class Project
    class Configuration
      attr_accessor :arduino_app_directory

      def initialize
        self.arduino_app_directory = '/Applications/Arduino.app'
      end
    end
  end
end
