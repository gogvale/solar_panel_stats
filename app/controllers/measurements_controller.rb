# frozen_string_literal: true

class MeasurementsController < ApplicationController
  def dashboard
    @todays_measure = Measurement.where(created_at: 1.day.ago..nil)
                                 .group_by_minute(:created_at, format: '%k:%M')
                                 .sum(:current_power)
                                 .reject{|i,v| v.zero?}
    @weekly_measure = Measurement.where(created_at: 1.week.ago..nil)
                                 .group_by_day_of_week(:created_at, format: '%a')
                                 .maximum(:created_at)
                                 .map { |key, i| { key => Measurement.find_by(created_at: i)&.yield_today || 0 } }
                                 .reduce({}, :update)
    @yearly_measure = (0..12).to_a.reverse.map do |j|
      time = j.months.ago
      { "#{12-j}_#{time.strftime('%b')}" => Measurement.where(created_at: time.beginning_of_month..time.end_of_month)
                                          .group_by_day_of_month(:created_at)
                                          .maximum(:created_at)
                                          .map { |key, i| { key => Measurement.find_by(created_at: i)&.yield_today } }
                                          .reduce({}, :update)
                                          .compact_blank
                                          .values
                                          .sum }
    end.reduce({}, :update)
  end
end
