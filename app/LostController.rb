class LostController < UIViewController
  include MapKit
  ZoomLevel = CoordinateSpan.new 0.25, 0.25

  def viewDidLoad
    view.frame = navigationController.view.bounds
    refresh
  end

  def refresh
    @map.removeFromSuperview if @map
    create_map
    add_orphans
    center_map
    self.view.addSubview @map
    self.navigationController.navigationBarHidden = false
  end

  def center_map
    BW::Location.get(significant: true) do |result|
      @region = CoordinateRegion.new result[:to], ZoomLevel
      @map.region = @region if @region
    end
    @map.region = @region if @region
  end

  def create_map
    @map = MapView.new
    @map.frame = self.view.frame
    @map.delegate = self
    @map.shows_user_location = true
  end

  def mapView(target, viewForAnnotation: annotation)
    return nil if(annotation == @map.userLocation)

    pinView = MKPinAnnotationView.alloc.initWithAnnotation annotation, reuseIdentifier: 'my_annotation'
    pinView.canShowCallout = true
    detailButton = UIButton.buttonWithType UIButtonTypeDetailDisclosure
    detailButton.when(UIControlEventTouchUpInside) do
      showOrphan annotation
    end
    pinView.rightCalloutAccessoryView = detailButton
    pinView
  end

  def showOrphan annotation
    controller = UIApplication.sharedApplication.delegate.orphan_controller
    navigationController.pushViewController controller, animated:true
    controller.showOrphan annotation
  end

  def add_orphans
    Orphanage.new.each { |orphan| @map.addAnnotation orphan }  
  end
end
