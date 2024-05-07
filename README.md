
## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false,              |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false,              |
| last_name          | string | null: false,              |
| first_name         | string | null: false,              |
| read_last_name     | string | null: false,              |
| read_first_name    | string | null: false,              |
| birthday           | date   | null: false,              |


### Association

- has_many : items
- has_many : orders


## itemsテーブル
| Column             | Type         | Options                       |
| ------------------ | ------------ | ----------------------------- |
| item_name          | string       | null: false,                  |
| item_description   | text         | null: false,                  |
| item_category_id   | integer      | null: false,                  |
| item_condition_id  | integer      | null: false,                  |
| shipping_fee_id    | integer      | null: false,                  |
| shipping_region_id | integer      | null: false,                  |
| shipping_day_id    | integer      | null: false,                  |
| item_price         | integer      | null: false,                  |
| user               | references   | null: false, foreign_key:true |

### Association

- belongs_to : user
- has_one : order

## ordersテーブル
| Column             | Type         | Options                            |
| ------------------ | ------------ | ---------------------------------- |
| user               | references   | null: false, foreign_key:true      |
| item               | references   | null: false, foreign_key:true      |

### Association

- belongs_to : user
- belongs_to : item
- belongs_to : residence

## residencesテーブル
| Column             | Type         | Options                            |
| ------------------ | ------------ | ---------------------------------- |
| post_code          | string       | null: false,                       |
| prefecture_id      | integer      | null: false,                       |
| municipalities     | string       | null: false,                       |
| house_number       | string       | null: false,                       |
| building_name      | string       |                                    |
| phone_number       | string       | null: false,                       |
| order              | references   | null: false, foreign_key:true      |

### Association

- belongs_to : order
