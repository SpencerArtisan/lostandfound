Orphan = Struct.new(:lat, :lon, :description, :image_url, :found_at) do
  alias_method :title, :description

  def coordinate
    CLLocationCoordinate2DMake lat, lon
  end

  def subtitle
    "Found today at #{found_at.strftime('%H:%M')}"
  end
end

