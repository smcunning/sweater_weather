# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attribute :email, :api_key
end
