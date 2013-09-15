require 'spec_helper'

describe ActiveAdmin::ViewsHelper do

  let!(:first)  { create(:department) }
  let!(:second) { create(:department, parent_id: first.id) }
  let!(:third)  { create(:department, parent_id: second.id) }
  let!(:forth)  { create(:department, parent_id: third.id) }

  describe "department_ancestry_links" do
    it "returns links to each ancestor for a given Department" do
      helper.department_ancestry_links(forth).should eq("#{link_to first.name, [:admin, first]} / #{link_to second.name, [:admin, second]} / #{link_to third.name, [:admin, third]}".html_safe)
    end
  end

  describe "department_employees_count" do
    it "returns number of employees for a given count" do
      helper.department_employees_count(0).should eq('<span class="no-employees">0 employees</span>'.html_safe)
      helper.department_employees_count(1).should eq('1 employee')
      helper.department_employees_count(9).should eq('9 employees')
    end
  end
end
