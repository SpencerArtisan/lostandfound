class OrphanageServer
  URL = 'http://lostandfoundserver.herokuapp.com/orphans.json'

  def all &block
    BW::HTTP.get(URL) do |response|
      if response.ok?
        block.call response.body.to_str
      else
        error = Exception.new "There was a problem connecting to the internet.  Please try again later."
        UIApplication.sharedApplication.delegate.handle_error error
      end
    end
  end

  def save orphan
    payload = {payload: {orphan: orphan}}
    BW::HTTP.post URL, payload
  end
end
