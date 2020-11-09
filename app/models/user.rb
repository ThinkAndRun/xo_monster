class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email,
            presence: true,
            email: true,
            uniqueness: { case_sensitive: false }

  before_save { self.email.downcase! }
  after_create :add_xo_monster_friendship!

  def friendships_sent
    Friendship.sent(id)
  end

  def friendships_received
    Friendship.received(id)
  end

  def friendships
    friendships_sent.or(friendships_received)
  end

  def friends
    friend_ids = friendships.confirmed
                            .pluck(:sender_user_id, :receiver_user_id)
                            .flatten.uniq.-([id])
    self.class.where(id: friend_ids)
  end

  def xo_sessions_as_x
    XoSession.as_x(id)
  end

  def xo_sessions_as_o
    XoSession.as_o(id)
  end

  def xo_sessions
    xo_sessions_as_x.or(xo_sessions_as_o)
  end

  private

  # TODO: Password reset hasn't been implemented yet

  # def generate_password_token!
  #   begin
  #     self.reset_password_token = SecureRandom.urlsafe_base64
  #   end while self.class.exists?(reset_password_token: self.reset_password_token)
  #   self.reset_password_token_expires_at = 1.day.from_now
  #   save!
  # end

  # def clear_password_token!
  #   self.reset_password_token = nil
  #   self.reset_password_token_expires_at = nil
  #   save!
  # end

  def add_xo_monster_friendship!
    xo_monster_id = Rails.configuration.xo_monster['id']
    return if id == xo_monster_id
    Friendship.create(sender_user_id: xo_monster_id,
                      receiver_user_id: id,
                      confirmed: true)
  end
end
