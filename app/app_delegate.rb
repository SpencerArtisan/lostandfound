class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController splash_controller
    true
  end

  def splash_controller
    @splash_controller ||= SplashController.alloc.init
  end

  def lost_controller
    @lost_controller ||= LostController.alloc.init
  end

  def found_controller
    @found_controller ||= FoundController.alloc.init
  end

  def polaroid_controller
    @polaroid_controller ||= PolaroidController.alloc.init
  end
end
