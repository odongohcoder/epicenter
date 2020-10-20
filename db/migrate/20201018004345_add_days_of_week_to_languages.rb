class AddDaysOfWeekToLanguages < ActiveRecord::Migration[5.2]
  def change
    add_column :languages, :days_of_week, :integer, array: true, default: []
    remove_column :languages, :skip_holiday_weeks, :boolean
  end
end
