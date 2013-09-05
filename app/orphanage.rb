class Orphanage
  def initialize service = OrphanageServer.new
    @service = service
  end

  def all &block
    @service.all do |json|
      puts "JSON FROM SERVICE: #{json}"
      json_orphans = BW::JSON.parse json
      json_orphans.each do |json_orphan| 
        date_formatter = NSDateFormatter.alloc.init
        date_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        found_at = date_formatter.dateFromString json_orphan['created_at']
        orphan = Orphan.new json_orphan['latitude'], json_orphan['longitude'], json_orphan['description'], json_orphan['image_url'], found_at
        puts "YIELDING ORPHAN: #{orphan.inspect}"
        block.call orphan
      end
    end
  end

  def add orphan
    hash_orphan = {'latitude' => orphan.lat, 'longitude' => orphan.lon, 'description' => orphan.description, 'image_url' => orphan.image_url}
    json_orphan = BW::JSON.generate hash_orphan
    puts "Saving orphan #{json_orphan}"
    @service.save hash_orphan
  end
end
