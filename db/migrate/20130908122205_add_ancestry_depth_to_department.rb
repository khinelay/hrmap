class AddAncestryDepthToDepartment < ActiveRecord::Migration
  def change
    add_column :departments, :ancestry_depth, :integer, default: 0
  end
end
