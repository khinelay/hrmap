class Setting < ActiveRecord::Base
  validates_presence_of :name, :value, :category
end
