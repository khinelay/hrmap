require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature "Department" do
  let!(:admin_user)       { create(:admin_user, role: "Super Admin") }

  let!(:f_department)     { create(:department) }
  let!(:f_f_department)   { create(:department, parent_id: f_department.id) }
  let!(:f_f_f_department) { create(:department, parent_id: f_f_department.id) }
  let!(:f_f_s_department) { create(:department, parent_id: f_f_department.id) }
  let!(:f_s_department)   { create(:department, parent_id: f_department.id) }
  let!(:f_s_f_department) { create(:department, parent_id: f_s_department.id) }
  let!(:f_s_s_department) { create(:department, parent_id: f_s_department.id) }
  let!(:f_s_t_department) { create(:department, parent_id: f_s_department.id) }
  let!(:f_t_department)   { create(:department, parent_id: f_department.id) }
  let!(:s_department)     { create(:department) }
  let!(:s_f_department)   { create(:department, parent_id: s_department.id) }
  let!(:s_f_f_department) { create(:department, parent_id: s_f_department.id) }
  let!(:s_f_s_department) { create(:department, parent_id: s_f_department.id) }
  let!(:t_department)     { create(:department) }

  let!(:f_user)           { create(:user, department_id: f_department.id) }
  let!(:s_user)           { create(:user, department_id: f_department.id) }

  let!(:f_f_user)         { create(:user, department_id: f_s_department.id) }
  let!(:f_s_user)         { create(:user, department_id: f_s_department.id) }
  let!(:f_t_user)         { create(:user, department_id: f_s_department.id) }

  background do
    login_with admin_user, $admin_user_password
    f_s_department.update_attribute :user_id, f_s_user.id
  end

  Steps "Admin Departments page" do
    Given "I'm on Department Index page" do ;
      visit admin_departments_path
    end

    Then "I should see Department list" do
      page.should have_content "5 employees"
      page.should have_link f_s_user.name, admin_user_path(f_s_user)
      page.should have_css('.no-employees', count: 12)
      page.should have_content "Displaying all 3 Departments"
    end
  end

  Steps "Admin Department page" do
    Given "I'm on Department Show page" do
      visit admin_department_path(f_s_department)
    end

    Then "I should see Department details" do
      page.should have_link f_department.name, href: admin_department_path(f_department)
      page.should have_css("a.department", count: 3)
      page.should have_css("a.leaded-by", count: 1)
      page.should have_css("a.employee", count: 3)
      page.should have_link f_f_user.name, admin_user_path(f_f_user)
      page.should have_link f_s_user.name, admin_user_path(f_s_user)
      page.should have_link f_t_user.name, admin_user_path(f_t_user)
    end

    When "I go on child Department Show page" do
      visit admin_department_path(f_s_f_department)
    end

    Then "I should see Department details" do
      page.should have_link f_department.name, href: admin_department_path(f_department)
      page.should have_link f_s_department.name, href: admin_department_path(f_s_department)
      page.should have_css("a.leaded-by", count: 0)
      page.should have_css("a.employee", count: 0)
      page.should have_css("div.attributes_table span.empty", count: 3)
    end
  end
end
