# Admin User
# Create 3 Admin Users
AdminUser.destroy_all
admin_user = AdminUser.new email: "c@talin.ro", password: "123qwe123", password_confirmation: "123qwe123"
p "Admin User #{admin_user.email} created." if admin_user.save

admin_user = AdminUser.new email: "admin1@hrmap.dev", password: "123qwe123", password_confirmation: "123qwe123"
p "Admin User #{admin_user.email} created." if admin_user.save

admin_user = AdminUser.new email: "admin2@hrmap.dev", password: "123qwe123", password_confirmation: "123qwe123"
p "Admin User #{admin_user.email} created." if admin_user.save

# Departments
# Create Department sample tree
Department.destroy_all
["Finance", "IT", "Design", "Logistics", "R&D"].each do |d|
  department = Department.new name: d
  p "Department #{department.name} created." if department.save
end
departments = []
Department.all.each do |d|
  rand(3).times do
    department = Department.new name: Faker::Lorem.words(10).sample.titleize, parent_id: d.id
    if department.save
      p "Department #{department.ancestors.collect{|a| a.name}.join(" / ")} / #{department.name} created."
      departments << department
    end
  end
end
sub_departments = []
departments.each do |d|
  rand(3).times do
    department = Department.new name: Faker::Lorem.words(10).sample.titleize, parent_id: d.id
    if department.save
      p "Department #{department.ancestors.collect{|a| a.name}.join(" / ")} / #{department.name} created."
      sub_departments << department
    end
  end
end
sub_sub_departments = []
sub_departments.each do |d|
  rand(3).times do
    department = Department.new name: Faker::Lorem.words(10).sample.titleize, parent_id: d.id
    if department.save
      p "Department #{department.ancestors.collect{|a| a.name}.join(" / ")} / #{department.name} created."
      sub_sub_departments << department
    end
  end
end

# Employees
User.destroy_all
user = User.new first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "john1@doe.com", password: "123qwe123", password_confirmation: "123qwe123", department: Department.first
if user.save
  p "Employee #{user.name} created."
  Department.first.update_attribute :user_id, user.id
end

user = User.new first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "john2@doe.com", password: "123qwe123", password_confirmation: "123qwe123", department: Department.first
p "Employee #{user.name} created." if user.save

user = User.new first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: "john3@doe.com", password: "123qwe123", password_confirmation: "123qwe123", department: Department.first.children.first
p "Employee #{user.name} created." if user.save
