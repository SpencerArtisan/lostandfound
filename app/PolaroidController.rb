class PolaroidController < UIViewController
  def viewDidLoad
    super
    createBackground
  end

  def createBackground
    image = UIImage.imageNamed 'NoticeBoard'
    self.view.backgroundColor = UIColor.alloc.initWithPatternImage image
  end

  def storeOrphan
    trackLocation
    addDescriptionEntryBox
  end

  def showOrphan orphan
    addDescriptionLabel orphan
  end

  def setImage image
    @image = image
    @image_view.removeFromSuperview if @image_view
    @image_view = UIImageView.alloc.initWithImage(image)
    @image_view.frame = [[37, 30], [248, 240]]
    view.addSubview(@image_view)

    image = UIImage.imageNamed 'SmallPin'
    @pin_view.removeFromSuperview if @pin_view
    @pin_view = UIImageView.alloc.initWithImage(image)
    @pin_view.frame = [[140, 3], [38, 38]]
    view.addSubview(@pin_view)
  end

  def trackLocation
    @locationManager = CLLocationManager.alloc.init
    @locationManager.startUpdatingLocation
  end

  def addDescriptionEntryBox
    @description_input.removeFromSuperview if @description_input
    @description_label.removeFromSuperview if @description_label
    @description_input = UITextField.alloc.initWithFrame [[40, 280], [244, 30]]
    @description_input.backgroundColor = UIColor.clearColor
    @description_input.setBorderStyle UITextBorderStyleNone
    @description_input.font = UIFont.fontWithName 'MarkerFelt-Thin', size: 24
    @description_input.textAlignment = UITextAlignmentCenter
    @description_input.becomeFirstResponder
    @description_input.delegate = self
    self.view.addSubview @description_input
  end

  def addDescriptionLabel orphan
    @description_input.removeFromSuperview if @description_input
    @description_label.removeFromSuperview if @description_label
    @description_label = UILabel.alloc.initWithFrame [[40, 280], [244, 30]]
    @description_label.backgroundColor = UIColor.clearColor
    @description_label.font = UIFont.fontWithName 'MarkerFelt-Thin', size: 24
    @description_label.textAlignment = UITextAlignmentCenter
    @description_label.text = orphan.title
    self.view.addSubview @description_label
  end

  def textFieldShouldReturn(target)
    App.alert "We have added your found item to our map!"
    save target.text
  end

  def save description
    found_where = @locationManager.location.coordinate
    puts "found #{description} here #{found_where.inspect}"
    image_url = ImageRepository.new.store @image, description
    orphan = Orphan.new found_where.latitude, found_where.longitude, description, image_url
    navigationController.popToRootViewControllerAnimated true
    Orphanage.new.add orphan
  end
end
