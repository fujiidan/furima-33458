# テーブル設計

## users テーブル

| Column          | Type    | Options                       |
| --------------- | ------- | ----------------------------- |
| nickname        | string  | null: false, uniqueness: true |
| email           | string  | null: false, uniqueness: true |
| password        | string  | null: false                   |
| first_name      | string  | null: false                   |  
| last_name       | string  | null: false                   |
| first_name_kana | string  | null: false                   |
| last_name_kana  | string  | null: false                   |
| user_birth_day  | integer | null: false                   |

### Association

- has_many :items
- has_many :orders
- has_many :addresses


## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | text       | null: false                    |
| text                | text       | null: false                    |
| price               | integer    | null: false                    |
| category            | integer    | null: false                    |  
| sales_status        | integer    | null: false                    |
| shipping_fee_status | integer    | null: false                    |
| prefecture          | integer    | null: false                    |
| scheduled_delivery  | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_one_attached :image


## orders テーブル

| Column | Type       | Options                        |
| -----  | ---------- | ------------------------------ |
| price  | integer    | null: false                    |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :addresses


## addresses テーブル

| Column       | Type       | Options                        |
| -------------| ---------- | ------------------------------ |
| postal_code  | integer    | null: false                    |
| prefecture   | integer    | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |  
| building     | string     |                                |
| phone_number | integer    | null: false                    |
| order        | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association
- belongs_to :order
- belongs_to :user