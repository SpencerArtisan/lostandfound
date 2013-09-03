class SplashController < UIViewController
  def viewDidLoad
    super
    image = UIImage.imageNamed 'LandingPage'
    self.view.backgroundColor = UIColor.alloc.initWithPatternImage image
    add_lost_button
  end

  def add_lost_button
    lost_button = UIButton.buttonWithType UIButtonTypeCustom
    lost_button.frame = [[40, 100], [200, 90]]
    self.view.addSubview lost_button
    lost_button.when(UIControlEventTouchUpInside) do
      lost_controller = LostController.alloc.initWithNibName nil, bundle: nil
      self.navigationController.pushViewController lost_controller, animated: true
    end
  end
end
