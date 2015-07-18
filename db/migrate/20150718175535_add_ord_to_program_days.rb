class AddOrdToProgramDays < ActiveRecord::Migration
  def change
    add_column :program_days, :ord, :integer
  end
end
