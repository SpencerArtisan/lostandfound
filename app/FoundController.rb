class FoundController < UIViewController
  SIMULATOR_IMAGE = UIImage.imageNamed('LandingPage')

  def take_picture
    if Device.simulator?
      show_orphan_view SIMULATOR_IMAGE
    else
      BW::Device.camera.rear.picture(media_types: [:image]) do |result|
        if result[:original_image]
          show_orphan_view result[:original_image]
        else
          navigationController.popViewControllerAnimated true
        end
      end
    end
  end

  def show_orphan_view(image)
    controller = UIApplication.sharedApplication.delegate.orphan_controller
    controller.storeOrphan image
    navigationController.pushViewController controller, animated:true
  end
end
