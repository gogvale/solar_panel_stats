class MeasurementsController < ApplicationController
  def dashboard
    @todays_measure = Measurement.where(created_at: 1.day.ago..nil)
                                 .group_by_minute(:created_at, format: "%l%P")
                                 .sum(:current_power)
    @weekly_measure = Measurement.where(created_at: 1.week.ago..nil)
                                 .group_by_day_of_week(:created_at, format: "%a")
                                 .sum(:current_power)
    @yearly_measure = Measurement.where(created_at: 1.year.ago..nil)
                                 .group_by_month(:created_at, format: "%b")
                                 .sum(:current_power)
  end
end
