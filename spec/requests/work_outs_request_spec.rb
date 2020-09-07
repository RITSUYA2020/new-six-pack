require 'rails_helper'

RSpec.describe 'WorkOuts', type: :request do
	describe 'GET #new' do
	    context '新規投稿ページが正しく表示される' do
			before do
				user = create(:user)
				sign_in user
				get new_work_out_path
			end
			it 'リクエストが成功すること' do
				expect(response.status).to eq 200
			end
			it 'タイトルが正しく表示されていること' do
				expect(response.body).to include('新規投稿')
			end
	    end
	end
end
