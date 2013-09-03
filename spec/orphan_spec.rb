describe Orphan do
  before do
    @orphan = Orphan.new 
    @now = Time.now
    @today_1540 = Time.gm @now.year, @now.month, @now.mday, 15, 40
  end

  it 'should create a subtitle for items found today' do
    @orphan.found_at = @today_1540
    @orphan.subtitle.should == 'Found today at 15:40'
  end

  it 'should create a subtitle for items found yesterday' do
    @orphan.found_at = @today_1540 - ( 60 * 60 * 24)
    @orphan.subtitle.should == 'Found yesterday at 15:40'
  end

  it 'should create a subtitle for items found before yesterday' do
    @orphan.found_at = @today_1540 - ( 60 * 60 * 24 * 2)
    @orphan.subtitle.should == 'Found 2 days ago at 15:40'
  end
end
