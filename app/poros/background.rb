# frozen_string_literal: true

class Background
  attr_reader  :id,
               :image,
               :credit

  def initialize(attributes)
    @id = 'null'
    @image = Image.new(attributes[:results][0][:urls])
    @credit = Credit.new(attributes[:results][0][:user])
  end
end
