module Workshop
  class Tasks
    include Rake::DSL
    def initialize(builder, uploader)

      desc 'create build directory'
      task :init do
        builder.create_build_directory
      end

      desc 'compile core, variant, and app source code'
      task :compile => [:init] do
        builder.compile
      end

      desc 'create archive from core, variant, and app source (except main loop file)'
      task :archive => [:compile] do
        builder.archive
      end

      desc 'link archive and main loop object file'
      task :link => [:archive] do
        builder.link
      end

      desc 'create eeprom file'
      task :eeprom => [:link] do
        builder.create_eeprom
      end

      desc 'create compiled *.hex file'
      task :hex => [:link] do
        builder.create_hex
      end

      desc 'delete build directory'
      task :clean do
        puts "Removing the build directory"
        builder.clean
      end

      desc 'upload *.hex file to arduino'
      task :upload => [:build] do
        uploader.upload
      end

      desc 'open a console to the arduino (ctrl-a ctrl-| to exit)'
      task :console do
        sh "screen #{uploader.com_port} 9600"
      end

      desc 'build *.hex and eeprom files'
      task :build => [:hex, :eeprom]

      desc 'find connected arduino and update config/com_port.yml with port'
      task :find do
        # TODO - find COM port and create config/com_port.yml
      end

      desc 'build application'
      task :default => :build
    end
  end
end
