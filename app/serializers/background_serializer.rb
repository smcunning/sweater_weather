# frozen_string_literal: true

class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attribute :image, &:image
  attribute :credit, &:credit
end
