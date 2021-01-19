# frozen_string_literal: true

require 'rails_helper'

describe Credit do
  it 'exists with attributes' do
    data = {
      id: '8DPIZXj6JrA',
      updated_at: '2021-01-16T19:50:02-05:00',
      username: 'sebbykurps',
      name: 'Sebastian Kurpiel',
      first_name: 'Sebastian',
      last_name: 'Kurpiel',
      twitter_username: 'Sebbykurps',
      portfolio_url: nil,
      bio: "Just a software engineer with a passion for photography.\r\nFollow me on Instagram at @SebbyKurps, to see more of my adventures All photos are geotagged here, www.sebastiankurpiel.com",
      location: nil,
      links: {
        self: 'https://api.unsplash.com/users/sebbykurps',
        html: 'https://unsplash.com/@sebbykurps',
        photos: 'https://api.unsplash.com/users/sebbykurps/photos',
        likes: 'https://api.unsplash.com/users/sebbykurps/likes',
        portfolio: 'https://api.unsplash.com/users/sebbykurps/portfolio',
        following: 'https://api.unsplash.com/users/sebbykurps/following',
        followers: 'https://api.unsplash.com/users/sebbykurps/followers'
      }
    }

    credit = Credit.new(data)
    expect(credit.author).to eq(data[:name])
    expect(credit.source).to be_an String
    expect(credit.source).to eq('unsplash.com')
    expect(credit.author_website).to eq(data[:links][:html])
  end
end
