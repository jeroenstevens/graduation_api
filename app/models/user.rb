class User < ActiveRecord::Base
  has_secure_password
  has_many :api_keys, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :collection, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  # default to the web scope if none is provided
  def find_api_key(targetScope = 'web')
      self.api_keys.where(scope: targetScope ? targetScope.upcase : 'WEB').first_or_create
  end
end
