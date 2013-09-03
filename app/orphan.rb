Orphan = Struct.new(:lat, :lon, :description, :image_url, :found_at) do
  alias_method :title, :description

  def coordinate
    CLLocationCoordinate2DMake lat, lon
  end

  def subtitle
    now = Time.now
    day_found = Time.new found_at.year, found_at.month, found_at.mday
    today = Time.new now.year, now.month, now.mday
    interval = today.timeIntervalSinceDate day_found
    days_ago = (interval / (60 * 60 * 24)).to_i
    day = case days_ago 
          when 0; 'today'
          when 1; 'yesterday'
          else; "#{days_ago} days ago"
          end
    time = found_at.strftime('%H:%M')
    "Found #{day} at #{time}"
  end
end

