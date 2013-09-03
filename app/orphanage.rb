class Orphanage
  def initialize service = OrphanageServer.new
    @service = service
  end

  def all &block
    @service.all do |json|
      puts "JSON FROM SERVICE: #{json}"
      json_orphans = BW::JSON.parse json
      json_orphans.each do |json_orphan| 
        orphan = Orphan.new json_orphan['latitude'], json_orphan['longitude'], json_orphan['description'], nil
        puts "YIELDING ORPHAN: #{orphan.inspect}"
        block.call orphan
      end
    end
  end
end
