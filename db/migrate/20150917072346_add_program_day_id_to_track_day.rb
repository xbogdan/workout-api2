class AddProgramDayIdToTrackDay < ActiveRecord::Migration
  def change
    add_column :track_days, :program_day_id, :integer
  end
end
