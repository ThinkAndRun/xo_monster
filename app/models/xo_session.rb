class XoSession < ApplicationRecord
  require "#{Rails.root}/lib/xo_game/board"

  belongs_to :x_user, class_name: 'User', foreign_key: :x_user_id, required: true
  belongs_to :o_user, class_name: 'User', foreign_key: :o_user_id, required: false
  belongs_to :winner, class_name: 'User', foreign_key: :winner_id, required: false
  belongs_to :loser, class_name: 'User', foreign_key: :loser_id, required: false

  scope :as_x, -> (user_id) { where(x_user_id: user_id) }
  scope :as_o, -> (user_id) { where(o_user_id: user_id) }

  validates :x_user_id, presence: true
  after_initialize :set_slug!

  def board
    m = settings.try(:[],'fieldSize').try(:[],'h')
    n = settings.try(:[],'fieldSize').try(:[],'w')
    k = settings.try(:[],'winLineLimit')
    return unless m && n && k
    Board.new(settings, steps)
  end

  def current_step_mark
    steps.length.even? ? 'X' : 'O'
  end

  private

  def set_slug!
    return if slug
    begin
      self.slug = SecureRandom.urlsafe_base64(20).delete('-_')[0, 8]
    end while self.slug.to_s.length != 8 || self.class.exists?(slug: self.slug)
  end
end