# README
## テーブル設計
### tasks テーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|content|text||
|expired_at|datetime||
|status|string||
|priority|integer||

### users テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password_digest|string|null: false|

## Heroku へのデプロイ手順
### 開始前のチェック項目
- [ ] Gemの追加
  ```
  gem 'net-smtp'
  gem 'net-imap'
  gem 'net-pop'
  ```
  ```
  $ bundle install
  ```
- [ ] package.json にて node のバージョンを "16.x" に指定。
  ```JSON
    "engines": {
    "node": "16.x"
    },
  ```
- [ ] Heroku stack のバージョンを "heroku-20" に指定。
  ```
  $ heroku stack:set heroku-20
  ```
- [ ] Bundler を実行できるプラットフォームを追加。
  ```
  $ bundle lock --add-platform x86_64-linux
  ```

### デプロイ手順
  ```
  $ heroku create   #Herokuに新しいアプリケーションを作成
  $ heroku buildpacks:set heroku/ruby   #rubyのbuildpackを追加
  $ heroku buildpacks:add --index 1 heroku/nodejs   #nodejsのbuildpackを追加
  $ git push heroku ブランチ名   #'master'または'ブランチ名:master'
  $ heroku run rails db:migrate   #データベースの移行
  $ heroku open   #アプリケーションにアクセス
  $ heroku config   #アプリ名を確認
  ```