require 'rails_helper'

RSpec.describe User, type: :model do
	describe 'バリデーション' do
		before do
			@user = create(:user)
		end
		subject { @user.valid? }
		describe 'nameカラム' do
			it '空欄でないこと' do
				@user.name = ''
				is_expected.to eq false;
			end
		end
		describe 'emailカラム' do
			it '空欄でないこと' do
				@user.email = ''
				is_expected.to eq false;
			end
		end
	end

	# 関連付けのテスト
	describe 'アソシエーション' do
		subject(:association) do
			# reflect_on_associationで対象のクラスと引数で指定するクラスの関連を返す
			described_class.reflect_on_association(target)
		end

		# work_outsとの関連付けをチェックしたい場合
		describe 'WorkOutモデルとの関係' do
			# targetは :work_outs に設定
			subject(:target) { :work_outs }
			it '1:Nとなっている' do
				# macro メソッドで関連づけを返す
				expect(association.macro).to eq :has_many
				# class_name で関連づいたクラス名を返す
				expect(association.class_name).to eq 'WorkOut'
			end
		end
		# favoritesとの関連付けをチェックしたい場合
		describe 'Favoriteモデルとの関係' do
			subject(:target) { :favorites }
			it '1:Nとなっている' do
				expect(association.macro).to eq :has_many
				expect(association.class_name).to eq 'Favorite'
			end
		end
	end

	describe 'インスタンスメソッド' do
		subject { described_class.new }
		it 'followed_by?(user)メソッドがあること' do
			expect(subject).to respond_to(:followed_by?)
		end
		it 'active_for_authentication?メソッドがあること' do
			expect(subject).to respond_to(:active_for_authentication?)
		end
		it 'create_notification_follow!メソッドがあること' do
			expect(subject).to respond_to(:create_notification_follow!)
		end
	end
end
