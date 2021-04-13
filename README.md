# テーブル設計

## users テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| last_name_kana  | string | null: false |
| first_name_kana | string | null: false |
| birth_date      | data   | null: false |


### Association

- has_many :items
- has_many :records

## items テーブル

| Column              | Type       | Options     |
| ------------------- | ---------- | ----------- |
| image               |            |             |
| name                | string     | null: false |
| info                | text       | null: false |
| category            | string     | null: false |
| sales_status        | string     | null: false |
| shipping_fee_status | string     | null: false |
| prefecture          | string     | null: false |
| prefecture          | string     | null: false |
| user                | references |             |
| record              | references |             |


### Association

- belongs_to :user
- has_one :record

## comments テーブル

| Column | Type       | Options |
| ------ | ---------- | ------- |
| user   | references |         |
| item   | references |         |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :shipping_address

## shipping_addresses テーブル

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| postal_code     | string | null: false |
| prefecture      | string | null: false |
| city            | string | null: false |
| address         | string | null: false |
| building        | string |             |
| phone_number    | string | null: false |


### Association

- belong_to :record