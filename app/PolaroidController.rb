class PolaroidController < UIViewController
  def viewDidLoad
    init_image_picker
    view.backgroundColor = UIColor.grayColor
  end

  def viewWillAppear(animated)
    presentModalViewController @image_picker, animated:false
  end

  def imagePickerController(picker, didFinishPickingImage:image, editingInfo:info)
    self.dismissModalViewControllerAnimated(true)
    add_image_view(image)
    apply_image_filter
  end

  def imagePickerControllerDidCancel(picker)
    self.dismissModalViewControllerAnimated(true)
    navigationController.popViewControllerAnimated false
  end

  private
  def init_image_picker
    @image_picker = UIImagePickerController.alloc.init
    @image_picker.delegate = self
    @image_picker.sourceType = camera_available ?
      UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary
  end

  def add_image_view(image)
    @image_view.removeFromSuperview if @image_view
    @image_view = UIImageView.alloc.initWithImage(image)
    @image_view.frame = [[10, 60], [300, 340]]
    view.addSubview(@image_view)
  end

  def camera_available
    UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceTypeCamera)
  end

  def apply_image_filter
    ci_image = CIImage.imageWithCGImage(@image_view.image.CGImage)
    filter = CIFilter.filterWithName("CIColorInvert")

    filter.setValue(ci_image, forKey:KCIInputImageKey)
    adjusted_image = filter.valueForKey(KCIOutputImageKey)

    new_image = UIImage.imageWithCIImage(adjusted_image)
    @image_view.image = new_image
  end
end
