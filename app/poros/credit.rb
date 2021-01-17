# frozen_string_literal: true

class Credit
  attr_reader :source, :author, :author_website

  def initialize(attributes)
    @source = 'unsplash.com',
              @author = attributes[:name]
    @author_website = attributes[:links][:html]
  end
end
