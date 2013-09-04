class PolaroidController < UIViewController
  def viewDidLoad
    super
    image = UIImage.imageNamed 'NoticeBoard'
    self.view.backgroundColor = UIColor.alloc.initWithPatternImage image
  end

  def set_image image
    @image_view.removeFromSuperview if @image_view
    @image_view = UIImageView.alloc.initWithImage(image)
    @image_view.frame = [[39, 77], [242, 224]]
    view.addSubview(@image_view)
  end
end
