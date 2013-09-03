class OrphanageServer
  def all &block
    BW::HTTP.get('http://lostandfound.eu01.aws.af.cm/orphans.json') do |response|
      puts "RESPONSE"
      puts response
      block.call response.body.to_str
    end
  end
end
