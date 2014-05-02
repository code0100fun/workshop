module Workshop
  class Project
    class Setup
      attr_accessor :base_directory

      def initialize(base_directory)
        self.base_directory = base_directory
      end

      def run
        create_base_directory
        create_sub_directories
      end

      def create_base_directory
        if Dir.exist?(base_directory)
          puts "folder already exists"
        else
          Dir.mkdir(base_directory)
        end
      end

      def create_sub_directories
        ['src', 'config'].each do |dirname|
          Dir.mkdir(base_directory + '/' + dirname)
        end
      end

    end
  end
end

