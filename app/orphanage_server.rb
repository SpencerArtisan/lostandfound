class OrphanageServer
  URL = 'http://lostandfoundserver.herokuapp.com/orphans.json'

  def all &block
    BW::HTTP.get(URL) do |response|
      puts "RESPONSE"
      puts response
      block.call response.body.to_str
    end
  end

  def save orphan
    payload = {payload: {orphan: orphan}}
    puts "Posting new orphan #{payload}"
    BW::HTTP.post(URL, payload) do |response|
      p response
    end
  end
end
