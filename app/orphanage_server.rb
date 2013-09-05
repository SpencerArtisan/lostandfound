class OrphanageServer
  def all &block
    BW::HTTP.get('http://lostandfound.eu01.aws.af.cm/orphans.json') do |response|
      puts "RESPONSE"
      puts response
      block.call response.body.to_str
    end
  end

  def save orphan
    BW::HTTP.post('http://lostandfound.eu01.aws.af.cm/orphans.json', {payload: "{orphan: #{orphan}}"}) do |response|
      p response
    end
  end
end
