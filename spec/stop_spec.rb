require 'spec_helper'

describe Stop do 

  context '#initialize' do 
    it 'initializes an instance of Stop with an array of attributes' do 
      Stop.new({'station_id' => 1, 'line_id' => 1}).should be_an_instance_of Stop
    end
  end

  context '#saves' do
    it 'saves a stop to the database' do
      stop = Stop.new({'line_id' => 1, 'station_id' => 1})
      expect {stop.save}.to change {Stop.all.count}.by 1
    end

     it 'returns the updated instance of the Stop object' do
       stop = Stop.new({'line_id' => 1, 'station_id' => 1}).save.should be_an_instance_of Stop
    end

    it 'sets the ID field in the original object'
  end

  context '#station_id' do
    it "returns the stop's station id" do
      stop = Stop.new('station_id' => 1)
      stop.station_id.should eq 1
    end
  end

  context '#line_id' do
    it "returns the stop's line id" do
      stop = Stop.new('line_id' => 1)
      stop.line_id.should eq 1
    end
  end

  context '#id' do
    it "returns the stop's id" do
      stop = Stop.new('id' => 1)
      stop.id.should eq 1
    end
  end

  context '.all' do
    it 'is empty at first' do
      Stop.all.should be_empty
    end

    it 'lists all of the stops that are saved in the database' do
      stops = [[1, 2], [3, 3], [1, 3]].map {|ids| Stop.new('station_id' => ids[0], 'line_id' => ids[1]).save}
      Stop.all.should =~ stops
    end
  end

  context '#==' do
    it 'says two instances of Stop are equal if they have the same id, station_id, and line_id' do
      stop1 = Stop.new({'line_id' => 1, 'station_id' => 1})
      stop2 = Stop.new({'line_id' => 1, 'station_id' => 1})
      stop1.should eq stop2
    end
  end


  context '#list_by_station_id' do
    it 'returns a list of all lines that match the station_id in the stops table' do 
      stop1 = Stop.new({'line_id' => 1, 'station_id' => 2}).save
      stop2 = Stop.new({'line_id' => 3, 'station_id' => 4}).save
      Stop.list_by_station_id(2).first.should eq stop1
    end
  end

  context '#list_by_line_id' do

    it 'returns a list of all stations that match the line_id in the stops table' do 
      stop1 = Stop.new({'line_id' => 1, 'station_id' => 2}).save
      stop2 = Stop.new({'line_id' => 3, 'station_id' => 4}).save
      Stop.list_by_line_id({'line_id' => 3}).first.should eq stop2
    end
  end
end