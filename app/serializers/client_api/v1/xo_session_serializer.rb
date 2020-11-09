class ClientApi::V1::XoSessionSerializer < BaseSerializer
  attributes(
      :slug,
      :settings,
      :steps,
      :board,
      :current_step_mark,
      :finished,
      :winner_mark,
      :started_at,
      :last_step_at,
      :created_at
  )

  belongs_to :x_user, serializer: ClientApi::V1::FriendSerializer
  belongs_to :o_user, serializer: ClientApi::V1::FriendSerializer
  belongs_to :winner, serializer: ClientApi::V1::FriendSerializer
  belongs_to :loser, serializer: ClientApi::V1::FriendSerializer

  def board
    object.board&.render || []
  end

  def finished
    object.board&.finished?
  end

  def winner_mark
    object.board&.winner_mark
  end
end