require 'rails_helper'

RSpec.describe ClientApi::V1::FriendsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in_as(user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response_json).to include('friends')
    end

    context 'when user has friends' do
      let(:friend) { create(:user) }
      let!(:friendship) do
        create(:friendship,
               sender_user_id: user.id,
               receiver_user_id: friend.id,
               confirmed: true)
      end

      it "returns user's friends" do
        get :index
        expect(response).to be_successful
        expect(response_json.size).to eq 1
        expect(response_json['friends'].first['id']).to eq friend.id
      end
    end
  end
end