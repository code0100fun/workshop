require 'spec_helper'

describe Workshop::Project::Configuration::Build do

  describe '#mcu' do
    it 'returns "atmega328p" as the default mcu' do
      expect(subject.mcu).to eq('atmega328p')
    end
  end

  describe '#core' do
    it 'returns "arduino" as the default core' do
      expect(subject.core).to eq('arduino')
    end
  end

  describe '#variant' do
    it 'returns "standard" as the default variant' do
      expect(subject.variant).to eq('standard')
    end
  end

  describe '#f_cpu' do
    it 'returns "8000000L" as the default cpu frequency' do
      expect(subject.f_cpu).to eq('8000000L')
    end
  end

  describe '#vid' do
    it 'returns nil as the default vid' do
      expect(subject.vid).to eq(nil)
    end
  end

  describe '#pid' do
    it 'returns nil as the default pid' do
      expect(subject.pid).to eq(nil)
    end
  end

  describe '#libraries' do
    it 'initialized with an empty array of libraries' do
      expect(subject.libraries).to eq([])
    end
  end

  describe '#includes' do
    it 'initialized with an empty array of includes' do
      expect(subject.includes).to eq([])
    end
  end
end
