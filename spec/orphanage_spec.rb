describe Orphanage do
  it 'should pull orphans from a json service' do
    service = stub :all do
      yield '[{"created_at":"2013-09-03T15:40:35Z","description":"Glove","id":1,"latitude":37.6,"longitude":-122.5,"updated_at":"2013-09-03T15:40:35Z"}]'
    end

    orphans = []
    Orphanage.new(service).all do |orphan|
      orphans << orphan
    end
    orphans.length.should == 1
    orphan = orphans[0]
    orphan.description.should == 'Glove'
    orphan.title.should == 'Glove'
    orphan.coordinate.latitude.should == 37.6
    orphan.coordinate.longitude.should == -122.5
    orphan.found_at.should == Time.local(2013, 9, 3, 15, 40, 35)
  end
end
