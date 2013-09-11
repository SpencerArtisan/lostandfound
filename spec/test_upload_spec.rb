describe 'a' do
  ACCESS_KEY_ID = "AKIAILWHUVCYWXNUMZ4A"
  SECRET_KEY    = "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"

  #it 'should upload a file' do
    #@s3 = AmazonS3Client.alloc.initWithAccessKey(ACCESS_KEY_ID, withSecretKey: SECRET_KEY)
    #image = UIImage.imageNamed 'SmallPin'
    #imageData = UIImageJPEGRepresentation(image, 1.0)
    #req = S3PutObjectRequest.alloc.initWithKey("pin1", inBucket: "LostAndFound").tap do |r|
      #r.contentType = "image/png"
      #r.data = imageData
      #r.cannedACL = 'public-read'
    #end

    #begin
      #response = @s3.putObject(req)
      #p response.body
    #rescue Exception => e
      #puts e.statusCode
    #end


    #1.should == 1
  #end
  #
  #it 'should resize images' do
    #image = UIImage.imageNamed 'LandingPage'
    #image = OrphanController.new.resize image
    #image = OrphanController.new.crop image
    #ImageRepository.new.store image, 'landing page'
  #end
end
