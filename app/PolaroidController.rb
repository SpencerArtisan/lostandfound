class PolaroidController < UIViewController
  def viewDidLoad
    super
    createBackground
    trackLocation
    addDescriptionEntryBox
    #addSaveButton
    #addCancelButton
    save
  end

  def createBackground
    image = UIImage.imageNamed 'NoticeBoard'
    self.view.backgroundColor = UIColor.alloc.initWithPatternImage image
  end

  def setImage image
    @image_view.removeFromSuperview if @image_view
    @image_view = UIImageView.alloc.initWithImage(image)
    @image_view.frame = [[38, 30], [247, 240]]
    view.addSubview(@image_view)

    image = UIImage.imageNamed 'SmallPin'
    @pin_view.removeFromSuperview if @pin_view
    @pin_view = UIImageView.alloc.initWithImage(image)
    @pin_view.frame = [[130, 3], [38, 38]]
    view.addSubview(@pin_view)
  end

  def trackLocation
    @locationManager = CLLocationManager.alloc.init
    @locationManager.startUpdatingLocation
  end

  def addDescriptionEntryBox
    @description_input = UITextField.alloc.initWithFrame [[40, 280], [244, 30]]
    @description_input.backgroundColor = UIColor.clearColor
    @description_input.setBorderStyle UITextBorderStyleNone
    @description_input.font = UIFont.fontWithName 'MarkerFelt-Thin', size: 24
    @description_input.textAlignment = UITextAlignmentCenter
    @description_input.becomeFirstResponder
    self.view.addSubview @description_input
  end

  def addSaveButton
    save_button = UIButton.buttonWithType UIButtonTypeRoundedRect
    save_button.setTitle 'Save', forState:UIControlStateNormal
    save_button.frame = [[20, 10], [100, 30]]
    self.view.addSubview save_button
    save_button.when(UIControlEventTouchUpInside) do
      save
    end
  end

  def addCancelButton
    cancel_button = UIButton.buttonWithType UIButtonTypeRoundedRect
    cancel_button.setTitle 'Cancel', forState:UIControlStateNormal
    cancel_button.frame = [[200, 10], [100, 30]]
    self.view.addSubview cancel_button
    cancel_button.when(UIControlEventTouchUpInside) do
      cancel
    end
  end

  def save
    found_where = @locationManager.location.coordinate
    puts "found here #{found_where.inspect}"
    orphan = Orphan.new found_where.latitude, found_where.longitude, 'thing', 'image url'
    #navigationController.popToRootViewControllerAnimated true
    Orphanage.new.add orphan
  end

  def cancel
    navigationController.popToRootViewControllerAnimated true
  end
end
