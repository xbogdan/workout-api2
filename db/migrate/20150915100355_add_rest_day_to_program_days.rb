class AddRestDayToProgramDays < ActiveRecord::Migration
  def change
    add_column :program_days, :rest_day, :boolean, default: false
  end
end
