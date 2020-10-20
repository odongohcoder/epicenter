class SeedLanguagesDaysOfWeeks < ActiveRecord::Migration[5.2]
  def change
    Track.active.map {|track| track.languages}.flatten.uniq.each do |language|
      if language.name == 'Evening'
        language.update(archived: true)
      else
        language.update(days_of_week: [1,2,3,4,5])
      end
    end
  end
end
