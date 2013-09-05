class OrphanageServer
  def all &block
    BW::HTTP.get('http://lostandfound.aws.af.cm/orphans.json') do |response|
      puts "RESPONSE"
      puts response
      block.call response.body.to_str
    end
  end

  def save orphan
    payload = {payload: {orphan: orphan}}
    puts "Posting new orphan #{payload}"
    BW::HTTP.post('http://lostandfound.aws.af.cm/orphans.json', payload) do |response|
      p response
    end
  end
end
