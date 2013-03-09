require 'spec_helper'

describe Station do
  context '#initialize' do 
    it 'creates an instance of Station with name of the station' do 
      station = Station.new({'name' => 'Red Station'})
      station.should be_an_instance_of Station
    end
  end

  context '#save' do
    it 'saves a station to the database' do
      station = Station.new({'name' => 'Red Station'})
      expect {station.save}.to change {Station.all.count}.by 1
    end
  end

  context '.all' do
    it 'is empty at first' do
      Station.all.should be_empty
    end

    # it 'lists all of the stations that are saved in the database' do
    #   stations = ['blue', 'red', 'green'].map {|name| Station.new('name' => name).save}
    #   Station.all.should =~ stations
    # end
  end

  context '#==' do
    it 'says two instances of Station are equal if they have the same id and name' do
      station1 = Station.new({'name' => 'Red Station', 'id' => '1'})
      station2 = Station.new({'name' => 'Red Station', 'id' => '1'})
      station1.should eq station2
    end
  end

  context '#id' do
    it "returns the station's id" do
      station = Station.new('name' => 'red', 'id' => 1)
      station.id.should eq 1
    end
  end

  context '#name' do
    it "returns the station's name" do
      station = Station.new('name' => 'red', 'id' => 1)
      station.name.should eq 'red'
    end
  end

  context '#find_by_id' do 
    it 'returns the instance of station when ids match' do 
      station_id1 = Station.new({'name' => 'Red Station', 'id' => 1}).save
      station2 = Station.new({'name' => 'other station', 'id' => 2})
      station_id2 = station2.save
      Station.find_by_id(station_id2).first.should eq station2
    end
  end
end









