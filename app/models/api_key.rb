class ApiKey < ActiveRecord::Base
  before_create :generate_access_token, :set_expiry_date

  belongs_to :user

  validates :scope, inclusion: { in: %w( WEB IOS ANDROID ) }
  validates :user, presence: true

  def set_expiry_date
    self.expires_at = 14.days.from_now
  end

  def generate_access_token
    # Loop as long as there is no other object
    # with the same access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  def is_expired?
    return self.expires_at <= Time.now ? true : false
  end
end
