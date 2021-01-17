# frozen_string_literal: true

module Convertable
  def convert_datetime(datetime)
    Time.at(datetime).to_datetime.to_s
  end

  def convert_date(date)
    Time.at(date).to_date.to_s
  end

  def convert_time(time)
    Time.at(time).strftime('%k:%M')
  end

  def convert_wind_speed(speed)
    "#{speed} mph"
  end

  def convert_wind_degrees(degrees)
    sector = (degrees / 22.5) + 0.5
    compass = ['↑ N', '↗ NE', '→ E', '↘ SE', '↓ S', '↙ SW', '← W', '↖ NW']
    compass[(sector % 8)]
  end
end
