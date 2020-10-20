class RemoveTimestampsFromTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tracks, :created_at
    remove_column :tracks, :updated_at
  end
end
