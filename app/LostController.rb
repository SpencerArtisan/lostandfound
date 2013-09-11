class LostController < UIViewController
  include MapKit
  ZoomLevel = CoordinateSpan.new 0.25, 0.25

  def viewDidLoad
    super
    view.frame = navigationController.view.bounds
    refresh
  end

  def refresh
    create_map
    add_orphans
    center_map
    self.view.addSubview @map
    self.navigationController.navigationBarHidden = false
  end

  def center_map
    @@region ||= nil
    @map.region = @@region if @@region
    BW::Location.get(significant: true) do |result|
      @@region = CoordinateRegion.new result[:to], ZoomLevel
      @map.region = @@region
    end
  end

  def create_map
    @map = MapView.new
    @map.frame = self.view.frame
    @map.delegate = self
    @map.shows_user_location = true
    @map.delegate = self
  end

  def mapView(target, viewForAnnotation: annotation)
    return nil if(annotation == @map.userLocation)

    pinView = MKPinAnnotationView.alloc.initWithAnnotation annotation, reuseIdentifier: 'my_annotation'
    pinView.canShowCallout = true
    detailButton = UIButton.buttonWithType UIButtonTypeDetailDisclosure
    detailButton.when(UIControlEventTouchUpInside) do
      controller = UIApplication.sharedApplication.delegate.orphan_controller
      navigationController.pushViewController controller, animated:true
      puts "Gathering image from #{annotation.image_url}"
      image_url = NSURL.URLWithString annotation.image_url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
      imageData = NSData.dataWithContentsOfURL image_url
      image = UIImage.imageWithData imageData
      controller.setImage image
      controller.showOrphan annotation
    end
    pinView.rightCalloutAccessoryView = detailButton
    pinView
  end

  def add_orphans
    Orphanage.new.all { |orphan| @map.addAnnotation orphan }  
  end
end
