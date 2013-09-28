class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  before_destroy :last_admin_user?

  validates_presence_of :role

  def super_admin?
    role == "Super Admin"
  end

private

  def last_admin_user?
    errors.add :base, :last_admin_user if AdminUser.order(id: :asc).first == self
    errors.blank?
  end
end
