require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
	describe 'GET #index' do
		before do
			takashi = create(:takashi)
			satoshi = create(:satoshi)
			sign_in takashi
			get users_path
		end

		it 'リクエストが成功すること' do
			expect(response.status).to eq 200
		end
		it 'ユーザー名が表示されていること' do
			expect(response.body).to include "Takashi"
			expect(response.body).to include "Satoshi"
		end
	end

	describe 'GET #show' do
		context 'ユーザーが存在する場合' do
			before do
				takashi = create(:takashi)
				sign_in takashi
				get user_path(takashi)
			end
			it 'リクエストが成功すること' do
				expect(response.status).to eq 200
			end
			it 'ユーザー名が表示されていること' do
				expect(response.body).to include 'Takashi'
			end
		end
		context 'ユーザーが存在しない場合' do
		end
	end

	describe 'GET #edit' do
		before do
			takashi = create(:takashi)
			sign_in takashi
			get edit_user_path(takashi)
		end
		it 'リクエストが成功すること' do
			expect(response.status).to eq 200
		end
		it 'ユーザー名が表示されていること' do
			expect(response.body).to include 'Takashi'
    	end
    	it 'メールアドレスが表示されていること' do
    		expect(response.body).to include 'takashi@example.com'
    	end
    end

    describe 'patch #update' do
    	let(:takashi) { create :takashi }

		context 'パラメータが妥当な場合' do
			it 'リクエストが成功すること' do
				sign_in takashi
				patch user_path(takashi), params: { user: attributes_for(:satoshi) }
				expect(response.status).to eq 302
			end
			it 'ユーザー名が更新されること' do
				sign_in takashi
				expect do
					patch user_path(takashi), params: { user: attributes_for(:satoshi) }
				end.to change { User.find(takashi.id).name }.from('Takashi').to('Satoshi')
			end
			it 'リダイレクトすること' do
				sign_in takashi
				patch user_path(takashi), params: { user: attributes_for(:satoshi) }
				expect(response).to redirect_to user_path(User.last)
			end
		end
		context 'パラメータが不正な場合' do
			it 'リクエストが成功すること' do
				sign_in takashi
				patch user_path(takashi), params: { user: attributes_for(:user, :invalid) }
				expect(response.status).to eq 200
			end
			it 'ユーザー名が変更されないこと' do
				sign_in takashi
				expect do
					patch user_path(takashi), params: { user: attributes_for(:user, :invalid) }
				end.to_not change(User.find(takashi.id), :name)
			end
			it 'エラーが表示されること' do
				sign_in takashi
				patch user_path(takashi), params: { user: attributes_for(:user, :invalid) }
				expect(response.body).to include '名前とメールアドレスを入力してください。'
			end
		end
	end
end
