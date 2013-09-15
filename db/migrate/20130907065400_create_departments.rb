class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :ancestry
      t.integer :user_id

      t.timestamps
    end

    add_index :departments, :ancestry
    add_index :departments, :user_id
  end
end
