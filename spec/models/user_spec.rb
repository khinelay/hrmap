require 'spec_helper'

describe User do
  let!(:user) { create(:user, department_id: nil) }

  it "should return name" do
    user.name.should eq "#{user.first_name} #{user.last_name}"
  end
end
