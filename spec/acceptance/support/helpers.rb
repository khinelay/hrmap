module HelperMethods
  def login_with(resource, password)
    visit send("new_#{resource.class.name.underscore}_session_path")
    fill_in "Email", with: resource.email
    fill_in "Password", with: password
    click_button "Login"
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
