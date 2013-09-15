class User < ActiveRecord::Base
  after_commit :flush_cache

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name
  validates_presence_of :last_name

  belongs_to :department, counter_cache: true

  def name
    "#{first_name} #{last_name}"
  end

  def self.collection_for_select
    all.order("last_name asc, first_name asc").collect {|u| [u.name, u.id]}
  end

  def self.cached_collection_for_select
    Rails.cache.fetch [self, "users_for_select"] do
      self.collection_for_select
    end
  end

private
  def flush_cache
    Rails.cache.delete([self.class.name, "users_for_select"])
  end
end
