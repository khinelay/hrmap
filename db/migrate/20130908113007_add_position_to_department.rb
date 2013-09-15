class AddPositionToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :position, :integer, default: 1
  end
end
