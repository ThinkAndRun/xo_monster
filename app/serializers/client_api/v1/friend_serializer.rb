class ClientApi::V1::FriendSerializer < BaseSerializer
  attributes(
      :id,
      :name,
      :email,
      :player_name
  )

  def player_name
    object.name.present? ? object.name : object.email
  end
end