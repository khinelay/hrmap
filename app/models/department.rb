class Department < ActiveRecord::Base
  belongs_to :user
  has_many :users, -> { order "users.last_name asc, users.first_name asc"}

  validates_presence_of :name

  has_ancestry orphan_strategy: :rootify, cache_depth: true

  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :without_self, lambda {|self_id| where("id != ?", self_id) if self_id.present? }

  def total_employees
    if children.any?
      users_count + children.collect{|d| d.total_employees}.sum
    else
      users_count
    end
  end
end
