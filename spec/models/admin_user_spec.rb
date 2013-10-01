require 'spec_helper'

describe AdminUser do
  let!(:admin_user) { create(:admin_user, role: "Super Admin") }

  it "shouldn't destroy last AdminUser" do
    admin_user.destroy
    admin_user.errors[:base].should include I18n.t('activerecord.errors.models.admin_user.attributes.base.last_admin_user')
    AdminUser.count.should eq(1)
    AdminUser.last.should eq(admin_user)
  end
end
s
