class LostController < UIViewController
  include MapKit
  ZoomLevel = CoordinateSpan.new 0.25, 0.25

  def viewDidLoad
    super
    view.frame = navigationController.view.bounds
  end

  def viewWillAppear(animated)
    create_map
    add_orphans
    center_map
    self.view.addSubview @map
    self.navigationController.navigationBarHidden = false
  end

  def center_map
    @@region ||= nil
    puts "RETURN ON REGION #{@@region}"
    @map.region = @@region if @@region
    BW::Location.get(significant: true) do |result|
      @@region = CoordinateRegion.new result[:to], ZoomLevel
      @map.region = @@region
      puts "CENTRE ON REGION #{@@region}"
    end
  end

  def create_map
    @map = MapView.new
    @map.frame = self.view.frame
    @map.delegate = self
    @map.shows_user_location = true
  end

  def add_orphans
    Orphanage.new.all { |orphan| @map.addAnnotation orphan }  
  end
end
