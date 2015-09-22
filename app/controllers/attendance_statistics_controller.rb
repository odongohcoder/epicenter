class AttendanceStatisticsController < ApplicationController
  authorize_resource :cohort_attendance_statistics, only: :index
  authorize_resource :student_attendance_statistics, only: :show

  include AttendanceHelper

  def index
    @attendance_statistic = CohortAttendanceStatistics.new(params[:cohort_id])
  end

  def show
    @student_attendance_stats = StudentAttendanceStatistics.new(current_student)
  end

  def create
    cohort = Cohort.find(params[:cohort_id])
    redirect_to cohort_day_attendance_records_path(cohort, day: params[:attendance_records][:day])
  end
end
