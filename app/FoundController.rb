class FoundController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.grayColor
  end

  def take_picture
    BW::Device.camera.rear.picture(media_types: [:image]) do |result|
      if result[:original_image]
        add_image_view result[:original_image]
      else
        navigationController.popViewControllerAnimated true
      end
    end

  end

  def add_image_view(image)
    controller = UIApplication.sharedApplication.delegate.polaroid_controller
    navigationController.pushViewController controller, animated:true
    #@image_view.removeFromSuperview if @image_view
    #@image_view = UIImageView.alloc.initWithImage(image)
    #@image_view.frame = [[10, 60], [300, 340]]
    #view.addSubview(@image_view)
  end
end
