class Orphan
  def initialize(lat, long, name, link)
    @name = name 
    @coordinate = CLLocationCoordinate2D.new
    @coordinate.latitude = lat
    @coordinate.longitude = long 
    #@url = NSURL.alloc.initWithString(link)
  end  

  def title; @name; end
  def coordinate; @coordinate; end
  def url; @url; end
end

