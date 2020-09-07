FactoryBot.define do
	factory :user do # factory :testuser, class: User do のようにクラスを明示すればモデル名以外のデータも作ることができる
	    name { "hoge" }
	    email { "hoge@example.com" }
	    password { "hogehoge" }

	    trait :invalid do
	    	name { nil }
	  	end
	 end

	factory :takashi, class: User do
		name { "Takashi" }
		email { "takashi@example.com" }
		password { "hogehoge" }
	end

	factory :satoshi, class: User do
		name { "Satoshi" }
		email { "satoshi@example.com" }
		password { "hogehoge" }
	end
end
