class LostController < UIViewController
  include MapKit
  ZoomLevel = CoordinateSpan.new 0.25, 0.25

  def viewDidLoad
    view.frame = navigationController.view.bounds
  end

  def viewDidAppear(animated)
    refresh
  end

  def refresh
    self.navigationController.navigationBarHidden = false
    create_map
    center_map
    add_orphans
  end

  def center_map
    BW::Location.get(significant: true) do |result|
      @region = CoordinateRegion.new result[:to], ZoomLevel
      @map.region = @region if @region
    end
    @map.region = @region if @region
  end

  def create_map
    @map.removeFromSuperview if @map
    @map = MapView.new
    @map.frame = self.view.frame
    @map.delegate = self
    @map.shows_user_location = true
    self.view.addSubview @map
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
    Orphanage.new.each do |orphan| 
      @map.addAnnotation orphan 
    end
  end
end
