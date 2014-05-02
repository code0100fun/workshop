require 'spec_helper'

describe Workshop::Project::Configuration do
  describe '#arduino_app_directory' do
    it 'defaults arduino app directory to standard OS X app location' do
      config = Workshop::Project::Configuration.new
      expect(config.arduino_app_directory).to eq('/Applications/Arduino.app')
    end
  end

  describe '#project_name' do
    it 'defaults project name to be the lowercased and underscored folder name' do
      Workshop::Project::Configuration.any_instance.stub(:app_directory).and_return('/a/Foo Bar')
      config = Workshop::Project::Configuration.new
      expect(config.project_name).to eq('foo_bar')
    end
  end

  describe '#app_directory' do
    it 'returns current working directory for app directory' do
      Dir.stub(:pwd).and_return('/foo/bar')
      config = Workshop::Project::Configuration.new
      expect(config.app_directory).to eq('/foo/bar')
    end
  end

  describe '#build' do
    it 'initialized with an instance of a build configuration' do
      expect(subject.build.class).to eq(Workshop::Project::Configuration::Build)
    end
  end

  describe '#upload' do
    it 'initialized with an instance of an upload configuration' do
      expect(subject.upload.class).to eq(Workshop::Project::Configuration::Upload)
    end
  end
end
