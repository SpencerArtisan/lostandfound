class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    # UIScreen describes the display our app is running on
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    splash_controller = SplashController.alloc.initWithNibName nil, bundle: nil
    navigation_controller = UINavigationController.alloc.initWithRootViewController splash_controller
    @window.rootViewController = navigation_controller

    true
  end
end