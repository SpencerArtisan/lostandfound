class LostController < UIViewController
  include MapKit
  ZoomLevel = CoordinateSpan.new 0.25, 0.25

  def viewDidLoad
    super
    map = create_map
    add_orphans map
    BW::Location.get(significant: true) do |result|
      p result[:to].latitude
      p result[:to].longitude
      map.region = CoordinateRegion.new result[:to], ZoomLevel
    end

    self.view.addSubview map
  end

  def create_map
    map = MapView.new
    map.frame = self.view.frame
    map.delegate = self
    map.shows_user_location = true
    map
  end

  def add_orphans map
    Orphan::All.each { |orphan| map.addAnnotation orphan }  
  end
end
