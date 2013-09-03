class LostController < UIViewController
  include MapKit
  ZoomLevel = CoordinateSpan.new 0.25, 0.25

  def viewDidLoad
    super
    map = create_map
    BW::Location.get(significant: true) do |result|
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
end
