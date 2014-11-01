class Collection < ActiveRecord::Base

  belongs_to :user
  has_many :items, dependent: :destroy

  validates :name, presence: true, uniqueness: {
    scope: :user_id, message: 'You already have collection with this name' }

  has_attached_file :image, styles: {
    vertical_rectangle: { geometry: "400x200>", format: :jpg }
  }

  validates_attachment :image, :content_type => { :content_type => ["image/jpg", "image/png"]  }

end
