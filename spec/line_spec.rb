require 'spec_helper'

describe Line do
  context '#initialize' do 
    it 'creates an instance of Line with name of the line' do 
      line = Line.new({'name' => 'Red Line'})
      line.should be_an_instance_of Line
    end
  end

  context '#save' do
    it 'saves a line to the database' do
      line = Line.new({'name' => 'Red Line'})
      expect {line.save}.to change {Line.all.count}.by 1
    end

    it 'returns the updated instance of the line object' do
       line = Line.new({'name' => 'Red Line'}).save.should be_an_instance_of String
    end
  end

  context '.all' do
    it 'is empty at first' do
      Line.all.should be_empty
    end

  #   it 'lists all of the lines that are saved in the database' do
  #     lines = ['blue', 'red', 'green'].map {|name| Line.new('name' => name)}
  #     lines.each {|line| line.save}
  #     Line.all.should == lines
  #   end
  end

  context '#==' do
    it 'says two instances of Line are equal if they have the same id and name' do
      line1 = Line.new({'name' => 'Red Line', 'id' => '1'})
      line2 = Line.new({'name' => 'Red Line', 'id' => '1'})
      line1.should eq line2
    end
  end

  context '#id' do
    it "returns the line's id" do
      line = Line.new('name' => 'red', 'id' => 1)
      line.id.should eq 1
    end
  end

  context '#name' do
    it "returns the line's name" do
      line = Line.new('name' => 'red', 'id' => 1)
      line.name.should eq 'red'
    end
  end

  context '#find_by_id' do 
    it 'returns the instance of station when ids match' do 
      line1 = Line.new({'name' => 'Red Line', 'id' => 1}).save
      line2 = Line.new({'name' => 'Red Line', 'id' => 1})
      line_id2 = line2.save
      Line.find_by_id(line_id2).first.should eq line2
    end
  end

  context '#stations' do
    it 'returns a list of stations that a line runs through' do
      line_id = Line.new({'name' => 'Red Line', 'id' => 1}).save
      line = Line.new({'name' => 'Red Line', 'id' => line_id})
      station_id = Station.new({'name' => 'DT', 'id' => 1}).save
      station = Station.new({'name' => 'DT', 'id' => station_id})
      stop = Stop.new({'line_id' => line_id, 'station_id' => station_id})
      line.stations.first.should eq station
    end
  end
end














