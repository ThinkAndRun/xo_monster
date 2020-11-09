require 'rails_helper'

RSpec.describe ClientApi::V1::SigninController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:user_params) { { email: user.email, password: user.password } }

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to include('csrf')
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized for invalid params' do
      post :create, params: { email: user.email, password: 'incorrect' }
      expect(response).to have_http_status(401)
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    before do
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      @tokens = session.login
    end

    it 'returns http success' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      delete :destroy
      expect(response).to be_successful
    end
  end
end