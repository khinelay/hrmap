require 'spec_helper'

describe Department do
  let!(:f_department)     { create(:department) }
  let!(:f_f_department)   { create(:department, parent_id: f_department.id) }
  let!(:f_f_f_department) { create(:department, parent_id: f_f_department.id) }
  let!(:f_f_s_department) { create(:department, parent_id: f_f_department.id) }
  let!(:f_s_department)   { create(:department, parent_id: f_department.id) }
  let!(:f_s_f_department) { create(:department, parent_id: f_s_department.id) }
  let!(:f_s_s_department) { create(:department, parent_id: f_s_department.id) }
  let!(:f_s_t_department) { create(:department, parent_id: f_s_department.id) }
  let!(:f_t_department)   { create(:department, parent_id: f_department.id) }

  let!(:f_user)           { create(:user, department_id: f_department.id) }
  let!(:s_user)           { create(:user, department_id: f_department.id) }

  let!(:f_f_user)         { create(:user, department_id: f_s_department.id) }
  let!(:f_s_user)         { create(:user, department_id: f_s_department.id) }
  let!(:f_t_user)         { create(:user, department_id: f_s_department.id) }

  let!(:f_s_f_user)       { create(:user, department_id: f_s_t_department.id) }
  let!(:f_s_s_user)       { create(:user, department_id: f_s_t_department.id) }
  let!(:f_s_t_user)       { create(:user, department_id: f_s_t_department.id) }
  let!(:f_s_fo_user)      { create(:user, department_id: f_s_t_department.id) }
  let!(:f_s_fi_user)      { create(:user, department_id: f_s_t_department.id) }
  let!(:f_s_si_user)      { create(:user, department_id: f_s_t_department.id) }

  it "should return users_count as total User count for a Department without children" do
    f_s_t_department.reload
    f_s_t_department.total_employees.should eq(6)
  end

  it "should return sum of childrent users_count as total User count for a Department with children" do
    f_department.reload
    f_s_department.reload
    f_s_t_department.reload
    f_s_department.total_employees.should eq(9)
    f_department.total_employees.should eq(11)
  end
end
