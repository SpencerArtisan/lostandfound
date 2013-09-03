describe Orphan do
  it 'should create a subtitle for items found today' do
    orphan = Orphan.new 
    now = Time.now
    orphan.found_at = Time.gm now.year, now.month, now.mday, 15, 40
    orphan.subtitle.should == 'Found today at 15:40'
  end
end
