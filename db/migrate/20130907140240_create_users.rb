class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :city
      t.string  :state
      t.integer :department_id
      t.string  :job
      t.string  :category
      t.string  :phone
      t.string  :avatar
      t.string  :cv
      t.date    :employment_date

      t.timestamps
    end
  end
end
