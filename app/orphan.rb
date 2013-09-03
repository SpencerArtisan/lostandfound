class Orphan
  def initialize(lat, long, name, link)
    @name = name 
    @coordinate = CLLocationCoordinate2D.new
    @coordinate.latitude = lat
    @coordinate.longitude = long 
    @url = NSURL.alloc.initWithString(link)
  end  

  def title; @name; end
  def coordinate; @coordinate; end
  def url; @url; end

  All = [
    Orphan.new(37.8, -122.4, 'Hat', 'http://en.wikipedia.org/wiki/Chimay_Brewery'),
  ]
end

