Orphan = Struct.new(:lat, :lon, :description, :image_url, :found_at) do
  alias_method :title, :description

  def coordinate
    CLLocationCoordinate2DMake lat, lon
  end
end

