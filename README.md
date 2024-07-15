# アプリケーション名

Sync

# アプリケーション概要

在庫不足を防止し、依頼方法の統一と記入漏れを防ぐことで、本社と支店間の配送依頼業務を効率化する

# URL

https://sync-app-k5sn.onrender.com

# テスト用アカウント

・ Basic認証パスワード：2222
・ Basic認証ID：admin
・ メールアドレス：xxx@xxx.com
・ パスワード：xxXXxX

# 利用方法

## 依頼の投稿

1. トップページのヘッダーから、所属で支店を選択しユーザー新規登録を行う
2. 一覧画面のヘッダーの「依頼する」から、依頼（品名・数）を入力し投稿する

## 依頼の対応

1. トップページのヘッダーから、所属で本社を選択しユーザー新規登録を行う
2. 一覧画面で投稿されている依頼の「状況」が「未対応」のものをクリックし、詳細画面へ遷移する
3. 「対応する」をクリックし、対応完了後「対応済にする」をクリックし状況を更新する
4. 連絡事項等があれば、コメントを送信する

## 在庫管理

1. トップページのヘッダーから、所属で本社を選択しユーザー新規登録を行う
2. 一覧画面のヘッダーの「在庫一覧」をクリックし、在庫一覧ページへ遷移する
3. 在庫一覧画面のヘッダーの「品名を追加」から、追加在庫内容（品名・在庫数・必要最低数）を入力し追加する
4. 編集する際は、在庫一覧画面の編集したい在庫をクリックし編集・削除を行う

# アプリケーションを作成した背景

前職での業務で、依頼を受け配送対応をする本社側と、依頼をする支店側それぞれに問題があった。
問題をアプリケーションの仕組みで解決できるのではと考え作成することにした。

本社の問題と解決方法
1. 支店からの依頼方法がバラバラで管理が大変 → 依頼方法を統一する
2. 必要事項が書かれていないと、やりとりの手間が増える → 必要事項を入力しないと依頼できないようにする
3. 在庫不足に気付かず、依頼時に即対応できないことがある → 必要最低数を設定する

支店の問題と解決方法
1. 本社から連絡がないと、対応してくれたのかわからない → 対応状況を確認できるようにする
2. 依頼に訂正や確認があった際、本社の誰に伝えればいいかわからない → 問い合わせ先の明確化

# 洗い出した要件
https://gyazo.com/98404fdeed797e46250517023605ec11

# 実装した機能についての画像やGIFおよびその説明

1. 依頼投稿機能
https://gyazo.com/cde7834e86ef9de2b4b6171c9df1a304

2. 依頼対応機能
https://gyazo.com/f15e4bc062402d28faa93ad7ba56e9a7

3. 在庫管理機能
https://gyazo.com/14f9b6a40419783ca4e36404fab8edbe

4. コメント機能
https://gyazo.com/3aba88ce0c95fe99052636a3b715861e

# 実装予定の機能

1. 依頼の状況に応じて分類し、状況別に表示できるようにする
2. 依頼の投稿、対応、コメントがついた際に通知がいくようにする

# データベース設計
https://gyazo.com/734c94f49df3004a2290ea1152f36ff9

# 画面遷移図
https://gyazo.com/82274a3367c86c3e1af3d655afe5c362

# テーブル設計

## users テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| lastname           | string     | null: false |
| firstname          | string     | null: false |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false |
| affiliation_id     | integer    | null: false, foreign_key: true |

### Association

- belongs_to :affiliation
- has_many :requests
- has_many :comments

## affiliations テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| name               | string     | null: false |

### Association

- has_many :users

## requests テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| article_id         | references | null: false, foreign_key: true |
| quantity           | integer    | null: false |
| status             | string     | null: false |
| user_id            | references | null: false, foreign_key: true |
| request_time       | datetime   | null: false |
| response_user_id   | integer    | foreign_key: true |
| response_time      | datetime   |             |

### Association

- has_many :comments
- belongs_to :user
- belongs_to :article
- belongs_to :response_user, class_name: 'User'

## comments テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| content            | text       | null: false |
| user_id            | references | null: false, foreign_key: true |
| request_id         | references | null: false, foreign_key: true |
| comment_time       | datetime   | null: false |

### Association

- belongs_to :user
- belongs_to :request

## stocks テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| article_id          | references | null: false, foreign_key: true |
| quantity            | integer    | null: false |
| minimum_stock_level | integer    |             |

### Association
- belongs_to :article

## articles テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| name                | string     | null: false |

### Association
- has_many :requests
- has_one :stock

# 開発環境

## インフラ
・ OS: macOS Sonoma 14.2
・ データベース: MySQL

## テスト
・ バックエンド: RSpec

## テキストエディタ
・ 推奨エディタ: Visual Studio Code

ローカルでの動作方法の記載がよくわからなかった