class PolaroidController < UIViewController
  def viewDidLoad
    super
    image = UIImage.imageNamed 'NoticeBoard'
    self.view.backgroundColor = UIColor.alloc.initWithPatternImage image
  end
end
