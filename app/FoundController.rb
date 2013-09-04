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
    controller.set_image image
    navigationController.pushViewController controller, animated:true
  end
end
