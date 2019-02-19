# frozen_string_literal: true

class UpdateCoursesWorker
  include Sidekiq::Worker

  def perform
    Currencies::Course.update_courses
  end
end
