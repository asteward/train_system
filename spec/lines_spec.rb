require 'spec_helper'

describe 'Line' do
  describe 'initialize' do
    it 'initializes a new line' do
      new_line = Line.new({:name => "15th ST Express"})
      expect(new_line).to be_a Line
    end
  end

  describe 'save' do
    it 'saves a line to the database' do
      new_line = Line.new({:name => "15th ST Express"})
      new_line.save
      expect(Line.all).to eq [new_line]
    end
  end
end
