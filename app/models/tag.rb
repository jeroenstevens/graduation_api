class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag

  has_many :items
  has_many :tags, -> { order('name ASC') }

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :user_id, message: 'You already have this tag' }
end
