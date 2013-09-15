class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Active Admin Overrides
  require 'active_admin/active_admin_views_pages_base.rb'
  require 'active_admin/index_as_sortable.rb'
end
