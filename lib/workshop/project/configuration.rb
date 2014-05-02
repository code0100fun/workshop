module Workshop
  class Project
    class Configuration
      attr_accessor :arduino_app_directory, :project_name, :source_directory, :build, :upload,
        :build_directory, :main_filename, :libraries

      def initialize
        self.arduino_app_directory = '/Applications/Arduino.app'
        self.project_name = default_project_name
        self.source_directory = default_source_directory
        self.build_directory = default_build_directory
        self.libraries = []
        self.build = Build.new
        self.upload = Upload.new
      end

      def includes
        build.includes
      end

      def default_project_name
        app_directory.split('/').last.parameterize.underscore
      end

      def default_build_directory
        app_directory + '/build'
      end

      def default_source_directory
        app_directory + '/src'
      end

      def app_directory
        Dir.pwd
      end

      def build_core
        build.core
      end

      def build_variant
        build.variant
      end

      def build_mcu
        build.mcu
      end

      def build_f_cpu
        build.f_cpu
      end

      def build_vid
        build.vid
      end

      def build_pid
        build.pid
      end

      def upload_protocol
        upload.protocol
      end

      def upload_speed
        upload.speed
      end

    end
  end
end
