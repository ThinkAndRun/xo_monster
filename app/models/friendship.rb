class Friendship < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: :sender_user_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_user_id

  scope :sent, -> (sender_id) { where(sender_user_id: sender_id) }
  scope :received, -> (receiver_id) { where(receiver_user_id: receiver_id) }
  scope :confirmed, -> { where(confirmed: true) }
  scope :unconfirmed, -> { where(confirmed: false) }

  validate :friendship_invitation_exists

  private

  def friendship_invitation_exists
    return unless sender_user_id_changed? || receiver_user_id_changed?
    if self.class.where(sender_user_id: sender_user_id, receiver_user_id: receiver_user_id).or(
       self.class.where(sender_user_id: receiver_user_id, receiver_user_id: sender_user_id))
           .exists?
      self.errors.add(:sender_user_id, 'Friendship invitation exists!')
    end
  end
end
