namespace :hrmap do
  desc 'Reset counters'
  task :reset_counters => ['environment'] do
    # Department - Users

    puts "# Resetting Department Users count:"
    Department.reset_column_information

    Department.all.each do |department|
      Department.update_counters department.id, users_count: department.users.size * (-1) + department.users.count
      puts "  - Department ##{department.id}: #{department.users.count} users."
    end
    puts "# Done."
  end
end
