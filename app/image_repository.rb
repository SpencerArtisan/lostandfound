class ImageRepository
  ACCESS_KEY_ID = "AKIAILWHUVCYWXNUMZ4A"
  SECRET_KEY    = "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"

  def store image, name
    image = resize image

    key = "#{name} - #{BubbleWrap.create_uuid}"
    @s3 = AmazonS3Client.alloc.initWithAccessKey(ACCESS_KEY_ID, withSecretKey: SECRET_KEY)
    imageData = UIImageJPEGRepresentation(image, 1.0)
    req = S3PutObjectRequest.alloc.initWithKey(key, inBucket: "LostAndFound").tap do |r|
      r.contentType = "image/jpeg"
      r.data = imageData
      r.cannedACL = 'public-read'
    end

    begin
      response = @s3.putObject(req)
    rescue Exception => e
      puts e.statusCode
      raise e
    end

    "https://s3.amazonaws.com/LostAndFound/#{key}"
  end

  def resize image
    resizer = BOSImageResizeOperation.alloc.initWithImage(image)
    resizer.resizeToFitWithinSize(CGSizeMake(320, 320))
    resizer.start
    resizer.result
  end
end
