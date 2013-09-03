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
end
