class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Active Admin Overrides
  before_filter :active_admin_override

  # Settings load
  before_filter :get_settings

private

  def active_admin_override
    require 'active_admin/index_as_sortable.rb' if request[:controller].include? "admin"
  end

  def get_settings
    if request[:controller].include? "admin"
      Setting.where(category: ["admin", "all"]).each do |setting|
        SETTINGS[setting[:name].to_sym] = setting[:value]
      end
    else
      Setting.where(category: ["site", "all"]).each do |setting|
        SETTINGS[setting[:name].to_sym] = setting[:value]
      end
    end
  end
end
