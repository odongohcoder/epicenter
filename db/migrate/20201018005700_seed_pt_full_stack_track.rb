class SeedPtFullStackTrack < ActiveRecord::Migration[5.2]
  def change
    c_track = Track.create(description: 'Part-Time C#/React')
    ruby_track = Track.create(description: 'Part-Time Ruby/React')
    intro_track = Track.find_by(description: 'Part-Time Intro to Programming')

    intro = Language.create(name: 'Intro (part-time track)', level: 0, number_of_days: 24, days_of_week: [0,1,2,3]) # 6 weeks
    js = Language.create(name: 'JavaScript (part-time track)', level: 1, number_of_days: 32, days_of_week: [0,1,2,3]) # 8 weeks
    csharp_dotnet = Language.create(name: 'C# and .NET (part-time track)', level: 2, number_of_days: 52, days_of_week: [0,1,2,3]) # 13 weeks
    ruby_rails = Language.create(name: 'Ruby and Rails (part-time track)', level: 2, number_of_days: 52, days_of_week: [0,1,2,3]) # 13 weeks
    react = Language.create(name: 'React (part-time track)', level: 3, number_of_days: 52, days_of_week: [0,1,2,3]) # 13 weeks

    c_track.languages = [intro, js, csharp_dotnet, react]
    ruby_track.languages = [intro, js, ruby_rails, react]
    intro_track.languages = [intro]
  end
end
