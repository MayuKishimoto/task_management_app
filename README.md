# README
### tasksテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|content|text||

### usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false, unique: true|
|password_digest|string|null: false|