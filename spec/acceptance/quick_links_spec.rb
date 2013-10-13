require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Quick Links" do
  scenario "I'm accessing the #sidebar links", js: true do
    Given "I'm on Home Page" do
      visit root_path
    end

    And "I click #quick-actions-link link" do
      page.find("#quick-actions-link").click
    end

    Then "I should see the sidebar opened" do
      page.should have_css(".wrapper.inactive", count: 1)
    end

    And "I click #quick-actions-link link" do
      page.find("#quick-actions-link").click
    end

    Then "I should see the sidebar opened" do
      page.should have_css(".wrapper.inactive", count: 0)
    end

    And "I should see Important Issues" do
      page.should have_link("#{I18n.t('site.quick_actions.important_issues')} (11)", "")
    end

    And "I should see Latest Searches" do
      page.should have_link("#{I18n.t('site.quick_actions.latest_searches')} (10)", "")
    end
  end
end
