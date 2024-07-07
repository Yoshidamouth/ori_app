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

### Association

- belongs_to :user
- belongs_to :request

## stocks テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| article_id          | references | null: false, foreign_key: true |
| quantity            | integer    | null: false |
| minimum_stock_level | integer    | null: false |

### Association
- belongs_to :article

## articles テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| name                | string     | null: false |

### Association
- has_many :requests
- has_one :stock