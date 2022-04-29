# frozen_string_literal: true

class Measurement < ApplicationRecord
  before_create :adjust_created
  before_save :adjust_saved

  private

  def adjust_created
    offset = time_difference
    self.created_at = offset
    self.updated_at = offset
  end

  def adjust_saved
    offset = time_difference
    self.updated_at = offset
  end

  def time_difference
    time1 = Time.zone.now.in_time_zone('UTC')
    time2 = Time.zone.now.in_time_zone('Monterrey')
    time_difference_in_seconds = time2.utc_offset - time1.utc_offset
    time1 - (time_difference_in_seconds / 60 / 60).abs.hours
  end
end
