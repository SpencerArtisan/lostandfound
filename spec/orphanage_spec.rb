describe Orphanage do
  it 'should pull orphans from a json service' do
    service = stub :all, :yield => '[{"created_at":"2013-09-03T15:40:35Z","description":"Glove","id":1,"latitude":37.6,"longitude":-122.5,"updated_at":"2013-09-03T15:40:35Z"}]'
    Orphanage.new(service).all do |orphans|
      orphans.length.should == 2
      orphan = orphans[0]
      orphan.description.should == 'Glove'
      orphan.coordinate.latitude.should == 37.6
      orphan.coordinate.longitude.should == -122.5
    end
    1.should == 1
    sleep 2
  end
end
