# rubyのバージョンを指定
FROM ruby:2.5.7

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
#sqlite3を指定
RUN apt-get update && apt-get install -y sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# コンテナ起動した時に、コンテナ内でmyappディレクトリを作成
RUN mkdir /myapp

# コンテナ内の作業ディレクトリの指定(上のRUNで作成したディレクトリ)
WORKDIR /myapp

# ホストOSのgemfileをコピーし、コンテナ内のディレクトリに貼り付け
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# 貼り付けたgemfileを読み込み。bundlerバージョンが2以降だとこれが必要
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler
RUN bundle install

# アプリケーション(カレントディレクトリ)をコピーして、コンテナ内のディレクトリに貼り付け
COPY . /myapp

# ポートを3000で公開
EXPOSE 3000

# コンテナにてコマンドを実行
# CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
