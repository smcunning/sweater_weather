# frozen_string_literal: true

require 'rails_helper'

describe Image do
  it 'exists with attributes' do
    data = {
      raw: 'https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?ixid=MXwxOTkzMzN8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MXwwfHw&ixlib=rb-1.2.1',
      full: 'https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?crop=entropy&cs=srgb&fm=jpg&ixid=MXwxOTkzMzN8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MXwwfHw&ixlib=rb-1.2.1&q=85',
      regular: 'https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzMzN8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MXwwfHw&ixlib=rb-1.2.1&q=80&w=1080',
      small: 'https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzMzN8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MXwwfHw&ixlib=rb-1.2.1&q=80&w=400',
      thumb: 'https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzMzN8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MXwwfHw&ixlib=rb-1.2.1&q=80&w=200'
    }

    image = Image.new(data)
    expect(image.image_url).to eq(data[:full])
  end
end
