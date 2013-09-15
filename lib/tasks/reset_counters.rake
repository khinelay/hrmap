namespace :hrmap do
  desc 'Reset counters'
  task :reset_counters => ['environment'] do
    Department.reset_column_information

    Department.all.each do |department|
      department.update_attribute :users_count, department.users.count
    end
  end
end
