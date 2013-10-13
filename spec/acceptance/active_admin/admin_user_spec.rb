require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature "Admin User" do
  let!(:admin_user)   { create(:admin_user, role: "Super Admin") }
  let!(:another_user) { create(:admin_user, role: "Super Admin") }

  background do
    login_with admin_user, $admin_user_password
  end

  Steps "Admin Users page" do
    Given "I'm on Admin User Index page" do
      visit admin_admin_users_path
    end

    Then "I should see Admin User list" do
      page.should have_link admin_user.email, href: admin_admin_user_path(admin_user)
      page.should have_content admin_user.last_sign_in_ip
      page.should have_link another_user.email, href: admin_admin_user_path(another_user)
      page.should have_content "Displaying all 2 Admin User"
    end
  end

  Steps "Admin User page" do
    Given "I'm on Admin User Show page" do
      visit admin_admin_user_path(admin_user)
    end

    Then "I should see Admin User details" do
      page.should have_content admin_user.email
      page.should have_content admin_user.sign_in_count
      page.should have_content admin_user.last_sign_in_ip
      page.should have_content admin_user.last_sign_in_at
      page.should have_content admin_user.current_sign_in_ip
      page.should have_content admin_user.current_sign_in_at
    end
  end
end
