describe Orphanage do
  it 'should pull orphans from a json service' do
    service = stub :all, :return => '[{"created_at":"2013-09-03T15:40:35Z","description":"Glove","id":1,"latitude":37.6,"longitude":-122.5,"updated_at":"2013-09-03T15:40:35Z"}]'
    orphans = Orphanage.new(service).all
    orphans.length.should == 1
    orphan = orphans[0]
    orphan.title.should == 'Glove'
    orphan.coordinate.latitude.should == 37.6
    orphan.coordinate.longitude.should == -122.5
  end

  it 'temp' do
    res = OrphanageServer.new.all { |res| res.should == 'dedd' }
  end
end
