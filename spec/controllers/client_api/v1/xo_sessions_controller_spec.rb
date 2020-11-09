RSpec.describe ClientApi::V1::XoSessionsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in_as(user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response_json).to include('xo_sessions')
    end

    context 'when user has xo sessions' do
      let(:x_user) { create(:user) }
      let!(:xo_session_x) { create(:xo_session, x_user_id: user.id) }
      let!(:xo_session_o) { create(:xo_session, x_user_id: x_user.id, o_user_id: user.id) }

      it "returns user's xo sessions" do
        get :index
        expect(response).to be_successful
        expect(response_json['xo_sessions'].length).to eq(2)
        expect(response_json['xo_sessions'].first['slug']).to eq(xo_session_x.slug).or eq(xo_session_o.slug)
      end
    end
  end

  describe 'POST #create' do
    let(:xo_session_params) { { settings: { foo: 'bar' }, steps: [{ foo: 'bar' }] } }

    it 'returns http success' do
      post :create, params: xo_session_params
      expect(response).to be_successful
      expect(response_json['xo_session']).to include('slug')
    end

    it 'creates a new XoSession' do
      expect do
        post :create, params: xo_session_params
      end.to change(XoSession, :count).by(1)
    end

    it 'does not save steps' do
      post :create, params: xo_session_params
      expect(response_json['xo_session']['steps']).to eq([])
      expect(response_json['xo_session']['settings']['foo']).to eq('bar')
    end
  end

  describe 'GET #show' do
    let!(:xo_session_x) { create(:xo_session, x_user_id: user.id) }

    it 'returns a success response' do
      get :show, params: { id: xo_session_x.slug }
      expect(response).to be_successful
    end

    context 'without authentication' do
      it 'returns a success response' do
        request.cookies[JWTSessions.access_cookie] = nil
        request.headers[JWTSessions.csrf_header] = nil
        get :show, params: { id: xo_session_x.slug }
        expect(response).to be_successful
      end
    end
  end

end