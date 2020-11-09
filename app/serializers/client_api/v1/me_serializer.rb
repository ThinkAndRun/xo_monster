class ClientApi::V1::MeSerializer < BaseSerializer
  attributes(
      :id,
      :name,
      :email
  )
end
