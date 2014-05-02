module Workshop
  class Project
    class Setup
      attr_accessor :project_name, :base_directory

      def initialize(base_directory, project_name)
        self.base_directory = base_directory
        self.project_name = project_name
      end

      def run
        create_base_directory
        create_sub_directories
        create_rakefile
        copy_blink_app
      end

      def log_create(name)
        puts "create #{name}".colorize(:green)
      end

      def relative(path)
        to = Pathname.new(path)
        from = Pathname.new(base_directory)
        rel = to.relative_path_from(from)
        rel.to_s
      end

      def create_base_directory
        if Dir.exist?(base_directory)
          puts "folder already exists"
        else
          log_create(relative(base_directory))
          Dir.mkdir(base_directory)
        end
      end

      def create_sub_directories
        ['src', 'config'].each do |dirname|
          dir = base_directory + '/' + dirname
          log_create(relative(dir))
          Dir.mkdir(dir)
        end
      end

      def resolve_file(file)
        dir = File.dirname(__FILE__)
        File.join(dir, file)
      end

      def read_file(file)
        File.read(resolve_file(file))
      end

      def write_file(file, contents)
        log_create(file)
        File.open(base_directory + '/' + file, 'w') do |file|
          file.puts contents
        end
      end

      def create_rakefile
        template = ERB.new(read_file('../templates/Rakefile.erb'))
        rakefile = template.result(binding)
        write_file('Rakefile', rakefile)
      end

      def copy_blink_app
        file = read_file('../templates/blink.cpp')
        write_file('src/' + project_name + '.cpp', file)
      end

    end
  end
end

