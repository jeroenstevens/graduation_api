class Collection < ActiveRecord::Base

  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: {
    scope: :user_id, message: 'You already have collection with this name' }

end
