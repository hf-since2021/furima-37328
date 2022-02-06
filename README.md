# README

# テーブル設計

## users テーブル

| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false               |
| last_name           | string | null: false               |
| first_name          | string | null: false               |
| last_name_reading   | string | null: false               |
| first_name_reading  | string | null: false               |
| birth_date          | date   | null: false               |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column                  | Type       | Options                        |
| ----------------------- | ---------- | ------------------------------ |
| user                    | references | null: false, foreign_key: true |
| name                    | string     | null: false                    |
| information             | text       | null: false                    |
| category_id             | integer    | null: false                    |
| sales_status_id         | integer    | null: false                    |
| shipping_fee_status_id  | integer    | null: false                    |
| prefecture_id           | integer    | null: false                    |
| scheduled_delivery_id   | integer    | null: false                    |
| price                   | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :order
- belongs_to_active_hash :category
- belongs_to_active_hash :sales_status
- belongs_to_active_hash :shipping_fee_status
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :scheduled_delivery
- has_one_attached :image


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order
- has_one :address


## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| order         | references | null: false, foreign_key: true |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |

- belongs_to :order
- belongs_to_active_hash :prefecture