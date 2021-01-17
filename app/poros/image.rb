class Image
  attr_reader :image_url
  def initialize(attributes)
    @image_url = attributes[:full]
  end
end
