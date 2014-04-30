module Workshop
  class Project
    attr_reader :config

    def self.configure(&block)
      new(&block)
    end

    def initialize(&block)
      self.config = Workshop::Project::Configuration.new
      block.call config
    end

    private
    def config=(config)
      @config = config
    end
  end
end
