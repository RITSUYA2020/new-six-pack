# SIXPACK
![image](https://user-images.githubusercontent.com/64945711/92579639-6891fb80-f2c8-11ea-90f9-749125f2acf6.png)

## サイト概要
最近、ちょっと太ってきたな...もっと筋肉つけたいな...<br>
よし、筋トレしよう！<br>
だけど、いざ始めると苦しくて面倒くさくなって3日坊主で終わってしまう...<br>
このサイトは筋トレに取り組む人同士の交流を促すことで、筋トレのモチベーションアップに繋げ、理想の体型を手に入れるスーパーマッチョなサイトです！<br>
基本機能として、新規投稿、その投稿にコメントができます。また、他のユーザーの投稿に「いいね」や、気になるユーザーをフォローすることができます。<br>
URL:https://sixpack.work/

### サイトテーマ
筋トレに取り組む人同士の交流を促し、モチベーションアップに繋げるサイト

### テーマを選んだ理由
自分自身、筋トレを続けていてモチベーションが低下してしまうことがあったため

### ターゲットユーザ
筋トレに取り組む人

### 主な利用シーン
筋トレ中

## 設計書

### 使用言語
Ruby 2.5.7</br>
Rails 5.2.4.3</br>
Javascript(jQuery)</br>

### 開発環境
Vagrant + VirtualBox →　Docker

### インフラ
AWS(EC2, RDS, Route53)<br>
MySQL2<br>
Nginx(Webサーバ)<br>
Capistrano
CircleCI

### AWS構成図
<img src="https://wals.s3-ap-northeast-1.amazonaws.com/uploads/wals2_content_img/455/architect_all.png">

### その他の技術(gem 等)
pry-byebug<br>
rspec-rails<br>
factory_bot_rails<br>
bullet<br>
spring-commands-rspec<br>
webdrivers<br>
devise<br>
devise-i18n<br>
devise-i18n-views<br>
enum_help<br>
bootstrap4<br>
jquery-rails<br>
refile<br>
refile-mini_magick<br>
rubocop<br>
rubocop-rails<br>
kaminari<br>
rails-i18n<br>
acts-as-taggable-on<br>
ransack<br>
simple_calendar<br>
lazy_high_charts<br>

### ER図
![SIXPACK_ER図](https://user-images.githubusercontent.com/64945711/104314637-11719100-551d-11eb-9e21-24d92f03ec8b.png)

### 主な機能
- ユーザー登録機能（ユーザー・管理者）
	- ログイン、ログアウト
	- プロフィール編集
- 投稿機能
	- 新規投稿
	- 編集、削除
- コメント機能（非同期）
	- 新規投稿
	- 削除
- カレンダー機能
- いいね機能（非同期）
- フォロー、フォロワー機能
- DM機能
- 通知機能（いいね・コメント)
- 検索機能（ユーザー・投稿)
- ソート機能(管理者用のユーザー一覧)
- お問い合わせ機能
- 天気表示
- 地図表示
- CSVエクスポート機能
- 画像プレビュー機能
- 画像拡大機能

### 機能一覧
https://docs.google.com/spreadsheets/d/17dG7breHOghgI3CEym-8vwV7O5gS1e2_BElRzf_k0RE/edit#gid=0
