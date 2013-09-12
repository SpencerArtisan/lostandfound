class Orphanage
  def initialize service = OrphanageServer.new
    @service = service
  end

  def add orphan
    hash_orphan = to_hash orphan
    @service.save hash_orphan
  end

  def to_hash orphan
    {'latitude' => orphan.lat, 'longitude' => orphan.lon, 'description' => orphan.description, 'image_url' => orphan.image_url}
  end

  def each &block
    begin
      @service.all do |json|
        extract_orphans json, &block
      end
    rescue => e
      puts e
      App.alert "There was a problem connecting to the internet."
    end
  end

  def extract_orphans json, &block
    json_orphans = BW::JSON.parse json
    json_orphans.each do |json_orphan| 
      begin
        orphan = from_json json_orphan
        block.call orphan
      rescue => e
        puts "Failed to build orphan from json: #{json}.  Error was #{e}"
      end
    end
  end

  def from_json json_orphan
    found_at = to_date json_orphan['created_at']
    Orphan.new json_orphan['latitude'], json_orphan['longitude'], json_orphan['description'], json_orphan['image_url'], found_at
  end

  def to_date date_string
    date_formatter = NSDateFormatter.new
    date_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    date_formatter.dateFromString date_string
  end
end
