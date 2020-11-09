FactoryBot.define do
  factory :friendship do
    sender_user_id { 1 }
    receiver_user_id { 1 }
    confirmed { false }
  end
end
