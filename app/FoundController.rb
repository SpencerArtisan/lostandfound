class FoundController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.grayColor
  end

  def take_picture
    if Device.simulator?
      add_image_view UIImage.imageNamed('LandingPage')
    else
      BW::Device.camera.rear.picture(media_types: [:image]) do |result|
        if result[:original_image]
          add_image_view result[:original_image]
        else
          navigationController.popViewControllerAnimated true
        end
      end
    end
  end

  def add_image_view(image)
    controller = UIApplication.sharedApplication.delegate.orphan_controller
    controller.setImage image
    controller.storeOrphan
    navigationController.pushViewController controller, animated:true
  end
end
