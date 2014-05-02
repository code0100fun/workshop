require 'thor'
require 'workshop/project/setup'

module Workshop
  class Cli < Thor

    desc "create NAME", "create a new project called NAME"
    long_desc <<-LONGDESC
      `workshop create foo` will create a new folder in the current directory\
      named `foo` and initialize an arduino project in that directory.
    LONGDESC
    def create(name)
      dir = File.expand_path('./' + name)
      Workshop::Project::Setup.new(dir).run
    end

  end
end

Workshop::Cli.start(ARGV)
