# SQL演習問題



<br>

## 0 前提条件

### 0.1 MySQLのインストール

本演習では、MySQL8.0を使用します。事前にインストールしてください。

https://dev.mysql.com/downloads/mysql/

<br>

### 0.2 テーブル定義

次のテーブルをベースに演習を進めます。

<br>

**ITEM（商品テーブル）**

| # | 列名<br>（物理） | 列名<br>（論理） | データ型 | PK | UK | NN | FK | デフォルト | 備考 |
|:-:|:--|:--|:--|:-:|:-:|:-:|:--|:--|:--|
| 1 | ID | 商品ID | INT | ● |  |  |  |  |  |
| 2 | NAME | 商品名 | VARCHAR(50) |  |  | ● |  |  |  |
| 3 | PRICE | 価格 | INT |  |  | ● |  |  |  |
| 4 | STATE | 状態 | VARCHAR(10) |  |  | ● |  |  | S、A、B、C、D、E *1 |
| 5 | M_CAT_ID | 中カテゴリID | INT |  |  |  | M_CATEGORY(ID) |  |  |
| 6 | PUBLIC_FLG | 公開フラグ | TINYINT(1) |  |  | ● |  | 1:公開 | 0:非公開、1:公開 |
| 7 | SELLER_ID | 出品者ユーザID | INT |  |  | ● | USER(ID) |  |  |
| 8 | BUYER_ID | 購入者ユーザID | INT |  |  |  | USER(ID) |  |  |
| 9 | PURCHASE_DT | 購入日時 | DATETIME |  |  |  |  |  |  |
| 10 | UPDATED_DT | 更新日時 | DATETIME |  |  | ● |  | 現在日時（更新時含む） |  |

> PK: Primary Key（主キー）、UK: Unique Key（一意）、NN: Not Null、FK: Foreign Key（外部キー）<br>*1）S: 新品同様、A: 未使用に近い、B: 目立った傷や汚れなし、C: やや傷や汚れあり、D: 傷や汚れあり、E: 全体的に状態が悪い

<br>

**GOOD（いいねテーブル）**

| # | 列名<br>（物理） | 列名<br>（論理） | データ型 | PK | UK | NN | FK | デフォルト | 備考 |
|:-:|:--|:--|:--|:-:|:-:|:-:|:--|:--|:--|
| 1 | ITEM_ID | 商品ID | INT | ● |  |  | ITEM(ID) |  |  |
| 2 | USER_ID | ユーザID | INT | ● |  |  | USER(ID) |  |  |

<br>

**USER（ユーザマスタ）**

| # | 列名<br>（物理） | 列名<br>（論理） | データ型 | PK | UK | NN | FK | デフォルト | 備考 |
|:-:|:--|:--|:--|:-:|:-:|:-:|:--|:--|:--|
| 1 | ID | ユーザID | INT | ● |  |  |  |  |  |
| 2 | EMAIL | メールアドレス | VARCHAR(100) |  | ● | ● |  |  |  |
| 3 | PASSWORD | パスワード | VARCHAR(100) |  |  | ● |  |  |  |
| 4 | NICKNAME | ニックネーム | VARCHAR(50) |  |  | ● |  |  |  |
| 5 | REGION | 発送元地域 | VARCHAR(30) |  |  | ● |  |  | 都道府県名 |

<br>

**M_CATEGORY（中カテゴリマスタ）**

| # | 列名<br>（物理） | 列名<br>（論理） | データ型 | PK | UK | NN | FK | デフォルト | 備考 |
|:-:|:--|:--|:--|:-:|:-:|:-:|:--|:--|:--|
| 1 | ID | 中カテゴリID | INT | ● |  |  |  |  |  |
| 2 | NAME | 中カテゴリ名 | VARCHAR(50) |  | ● | ● |  |  |  |
| 3 | L_CAT_ID | 大カテゴリID | INT |  |  | ● | L_CATEGORY(ID) |  |  |

<br>

**L_CATEGORY（大カテゴリマスタ）**

| # | 列名<br>（物理） | 列名<br>（論理） | データ型 | PK | UK | NN | FK | デフォルト | 備考 |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
| 1 | ID | 大カテゴリID | INT | ● |  |  |  |  |  |
| 2 | NAME | 大カテゴリ名 | VARCHAR(50) |  | ● | ● |  |  |  |

<br><br>

## 1 SQL演習

### 演習1　（難易度：★☆☆）

データベースの一覧を表示し、「freemarket」データベースがないことを確認してください。

<br>

### 演習2　（難易度：★☆☆）

「freemarket」データベースがなければ作成してください。

<br>

### 演習3　（難易度：★☆☆）

「freemarket」データベースに接続してください。

<br>

### 演習4　（難易度：★☆☆）

テーブル一覧を表示し、テーブルが1つもないことを確認してください。

**＜期待結果＞**

```sql
Empty set (0.00 sec)
```

<br>

### 演習5　（難易度：★☆☆）

以下のSQLファイルをダウンロードし、sourceコマンドを使用してデータの定義および挿入をしてください。

[SQLファイル](./sql/freemarket.sql)

<br>

### 演習6　（難易度：★☆☆）

あなたはフリマサイトを利用しています。当サイトにアクセスすると、出品されている商品の一覧が表示されます。商品テーブルから全商品情報の商品ID、商品名、価格、状態、更新日時を検索してください。

**＜期待結果＞**

```sql
+----+---------------------------------------------+--------+-------+---------------------+
| id | name                                        | price  | state | updated_dt          |
+----+---------------------------------------------+--------+-------+---------------------+
|  1 | ノートPC KroBook メモリ32GB SSD512GB        | 200000 | A     | 2022-05-10 10:18:32 |
|  2 | 実践SQL                                     |   1200 | D     | 2022-06-05 14:23:09 |
|  3 | レンズ 一眼レフカメラ用 50mm F1.4           |  45000 | A     | 2022-05-15 07:03:54 |
|  4 | 黒いタブレット SIMフリー 64GB               |  32000 | B     | 2022-05-19 11:32:11 |
|  5 | タブレット 9.7インチ シリコンケース         |   3800 | S     | 2022-05-19 16:51:10 |
|  6 | Javaプログラミング入門 第3版                |   2800 | B     | 2022-06-10 14:09:49 |
|  7 | 黒い粉                                      |    300 | S     | 2022-05-25 17:12:44 |
|  8 | 受講者Xの健診                               |    900 | A     | 2022-05-30 12:45:37 |
|  9 | 消せるボールペン                            |    300 | S     | 2022-06-04 09:51:56 |
| 10 | ミラーレス一眼カメラ K02X                   |  98000 | A     | 2022-06-08 19:20:54 |
| 11 | 新！Javaのすべてがわかる本                  |   1500 | C     | 2022-06-08 22:07:08 |
| 12 | プレミアム万年筆                            |   5000 | S     | 2022-06-09 15:43:11 |
| 13 | なぜSQLが使われるのか 第12版                |   4000 | S     | 2022-06-10 08:12:59 |
| 14 | ノートパソコン SiroBook メモリ32GB SSD256GB | 128000 | B     | 2022-06-15 10:50:38 |
| 15 | MySQL 8.0 マスター                          |    800 | E     | 2022-06-15 16:20:19 |
+----+---------------------------------------------+--------+-------+---------------------+
15 rows in set (0.00 sec)
```

<br>

### 演習7　（難易度：★☆☆）

最新の情報の順に商品を表示します。商品テーブルから全商品情報の商品ID、商品名、価格、状態、更新日時を更新日時の降順で検索してください。

**＜期待結果＞**

```sql
+----+---------------------------------------------+--------+-------+---------------------+
| id | name                                        | price  | state | updated_dt          |
+----+---------------------------------------------+--------+-------+---------------------+
| 15 | MySQL 8.0 マスター                          |    800 | E     | 2022-06-15 16:20:19 |
| 14 | ノートパソコン SiroBook メモリ32GB SSD256GB | 128000 | B     | 2022-06-15 10:50:38 |
|  6 | Javaプログラミング入門 第3版                |   2800 | B     | 2022-06-10 14:09:49 |
| 13 | なぜSQLが使われるのか 第12版                |   4000 | S     | 2022-06-10 08:12:59 |
| 12 | プレミアム万年筆                            |   5000 | S     | 2022-06-09 15:43:11 |
| 11 | 新！Javaのすべてがわかる本                  |   1500 | C     | 2022-06-08 22:07:08 |
| 10 | ミラーレス一眼カメラ K02X                   |  98000 | A     | 2022-06-08 19:20:54 |
|  2 | 実践SQL                                     |   1200 | D     | 2022-06-05 14:23:09 |
|  9 | 消せるボールペン                            |    300 | S     | 2022-06-04 09:51:56 |
|  8 | 受講者Xの健診                               |    900 | A     | 2022-05-30 12:45:37 |
|  7 | 黒い粉                                      |    300 | S     | 2022-05-25 17:12:44 |
|  5 | タブレット 9.7インチ シリコンケース         |   3800 | S     | 2022-05-19 16:51:10 |
|  4 | 黒いタブレット SIMフリー 64GB               |  32000 | B     | 2022-05-19 11:32:11 |
|  3 | レンズ 一眼レフカメラ用 50mm F1.4           |  45000 | A     | 2022-05-15 07:03:54 |
|  1 | ノートPC KroBook メモリ32GB SSD512GB        | 200000 | A     | 2022-05-10 10:18:32 |
+----+---------------------------------------------+--------+-------+---------------------+
15 rows in set (0.00 sec)
```

<br>

### 演習8　（難易度：★☆☆）

商品テーブルから公開中の商品情報の商品ID、商品名、価格、状態、更新日時を検索してください。

**＜期待結果＞**

```sql
+----+---------------------------------------------+--------+-------+---------------------+
| id | name                                        | price  | state | updated_dt          |
+----+---------------------------------------------+--------+-------+---------------------+
|  1 | ノートPC KroBook メモリ32GB SSD512GB        | 200000 | A     | 2022-05-10 10:18:32 |
|  2 | 実践SQL                                     |   1200 | D     | 2022-06-05 14:23:09 |
|  3 | レンズ 一眼レフカメラ用 50mm F1.4           |  45000 | A     | 2022-05-15 07:03:54 |
|  5 | タブレット 9.7インチ シリコンケース         |   3800 | S     | 2022-05-19 16:51:10 |
|  6 | Javaプログラミング入門 第3版                |   2800 | B     | 2022-06-10 14:09:49 |
|  7 | 黒い粉                                      |    300 | S     | 2022-05-25 17:12:44 |
|  8 | 受講者Xの健診                               |    900 | A     | 2022-05-30 12:45:37 |
| 10 | ミラーレス一眼カメラ K02X                   |  98000 | A     | 2022-06-08 19:20:54 |
| 11 | 新！Javaのすべてがわかる本                  |   1500 | C     | 2022-06-08 22:07:08 |
| 12 | プレミアム万年筆                            |   5000 | S     | 2022-06-09 15:43:11 |
| 13 | なぜSQLが使われるのか 第12版                |   4000 | S     | 2022-06-10 08:12:59 |
| 14 | ノートパソコン SiroBook メモリ32GB SSD256GB | 128000 | B     | 2022-06-15 10:50:38 |
| 15 | MySQL 8.0 マスター                          |    800 | E     | 2022-06-15 16:20:19 |
+----+---------------------------------------------+--------+-------+---------------------+
13 rows in set (0.00 sec)
```

<br>

### 演習9　（難易度：★★☆）

商品テーブルから公開中で、まだ購入されていない商品情報の商品ID、商品名、価格、状態、更新日時を検索してください。

**＜期待結果＞**

```sql
+----+---------------------------------------------+--------+-------+---------------------+
| id | name                                        | price  | state | updated_dt          |
+----+---------------------------------------------+--------+-------+---------------------+
|  1 | ノートPC KroBook メモリ32GB SSD512GB        | 200000 | A     | 2022-05-10 10:18:32 |
|  2 | 実践SQL                                     |   1200 | D     | 2022-06-05 14:23:09 |
|  3 | レンズ 一眼レフカメラ用 50mm F1.4           |  45000 | A     | 2022-05-15 07:03:54 |
|  6 | Javaプログラミング入門 第3版                |   2800 | B     | 2022-06-10 14:09:49 |
|  7 | 黒い粉                                      |    300 | S     | 2022-05-25 17:12:44 |
|  8 | 受講者Xの健診                               |    900 | A     | 2022-05-30 12:45:37 |
| 10 | ミラーレス一眼カメラ K02X                   |  98000 | A     | 2022-06-08 19:20:54 |
| 11 | 新！Javaのすべてがわかる本                  |   1500 | C     | 2022-06-08 22:07:08 |
| 12 | プレミアム万年筆                            |   5000 | S     | 2022-06-09 15:43:11 |
| 13 | なぜSQLが使われるのか 第12版                |   4000 | S     | 2022-06-10 08:12:59 |
| 14 | ノートパソコン SiroBook メモリ32GB SSD256GB | 128000 | B     | 2022-06-15 10:50:38 |
+----+---------------------------------------------+--------+-------+---------------------+
11 rows in set (0.00 sec)
```

<br>

### 演習10　（難易度：★☆☆）

商品テーブルから価格が 2000 ～ 5000 の商品情報の商品ID、商品名、価格、状態、更新日時を検索してください。

**＜期待結果＞**

```sql
+----+-------------------------------------+-------+-------+---------------------+
| id | name                                | price | state | updated_dt          |
+----+-------------------------------------+-------+-------+---------------------+
|  5 | タブレット 9.7インチ シリコンケース |  3800 | S     | 2022-05-19 16:51:10 |
|  6 | Javaプログラミング入門 第3版        |  2800 | B     | 2022-06-10 14:09:49 |
| 12 | プレミアム万年筆                    |  5000 | S     | 2022-06-09 15:43:11 |
| 13 | なぜSQLが使われるのか 第12版        |  4000 | S     | 2022-06-10 08:12:59 |
+----+-------------------------------------+-------+-------+---------------------+
4 rows in set (0.00 sec)
```

<br>

### 演習11　（難易度：★☆☆）

商品テーブルから商品名に「SQL」を含む商品情報の商品ID、商品名、価格、状態、更新日時を検索してください。

**＜期待結果＞**

```sql
+----+------------------------------+-------+-------+---------------------+
| id | name                         | price | state | updated_dt          |
+----+------------------------------+-------+-------+---------------------+
|  2 | 実践SQL                      |  1200 | D     | 2022-06-05 14:23:09 |
| 13 | なぜSQLが使われるのか 第12版 |  4000 | S     | 2022-06-10 08:12:59 |
| 15 | MySQL 8.0 マスター           |   800 | E     | 2022-06-15 16:20:19 |
+----+------------------------------+-------+-------+---------------------+
3 rows in set (0.00 sec)
```

<br>

### 演習12　（難易度：★★★）

商品テーブルから大カテゴリが「1: コンピュータ機器」に属する商品情報の商品ID、商品名、価格、状態、更新日時を検索してください。

**＜期待結果＞**

```sql
+----+---------------------------------------------+--------+-------+---------------------+
| id | name                                        | price  | state | updated_dt          |
+----+---------------------------------------------+--------+-------+---------------------+
|  1 | ノートPC KroBook メモリ32GB SSD512GB        | 200000 | A     | 2022-05-10 10:18:32 |
|  4 | 黒いタブレット SIMフリー 64GB               |  32000 | B     | 2022-05-19 11:32:11 |
|  5 | タブレット 9.7インチ シリコンケース         |   3800 | S     | 2022-05-19 16:51:10 |
| 14 | ノートパソコン SiroBook メモリ32GB SSD256GB | 128000 | B     | 2022-06-15 10:50:38 |
|  3 | レンズ 一眼レフカメラ用 50mm F1.4           |  45000 | A     | 2022-05-15 07:03:54 |
| 10 | ミラーレス一眼カメラ K02X                   |  98000 | A     | 2022-06-08 19:20:54 |
+----+---------------------------------------------+--------+-------+---------------------+
6 rows in set (0.00 sec)
```

<br>

### 演習13　（難易度：★★☆）

商品ID = 2 の商品情報の商品ID、商品名、価格、状態、中カテゴリ名を検索してください。

**＜期待結果＞**

```sql
+----+---------+-------+-------+-----------------+
| id | name    | price | state | m_cat_name      |
+----+---------+-------+-------+-----------------+
|  2 | 実践SQL |  1200 | D     | コンピュータ/IT |
+----+---------+-------+-------+-----------------+
1 row in set (0.00 sec)
```

<br>

### 演習14　（難易度：★★☆）

演習13において商品ID = 7 の商品情報が検索できるか確認しましょう。検索できない場合は、原因を考えてみて検索できるようにしてください。

**＜期待結果＞**

```sql
+----+--------+-------+-------+------------+
| id | name   | price | state | m_cat_name |
+----+--------+-------+-------+------------+
|  7 | 黒い粉 |   300 | S     | NULL       |
+----+--------+-------+-------+------------+
1 row in set (0.00 sec)
```

<br>

### 演習15　（難易度：★☆☆）

演習14において中カテゴリ名がNULLで取得されます。NULLの場合は「なし」で取得してください。

**＜期待結果＞**

```sql
+----+--------+-------+-------+------------+
| id | name   | price | state | m_cat_name |
+----+--------+-------+-------+------------+
|  7 | 黒い粉 |   300 | S     | なし       |
+----+--------+-------+-------+------------+
1 row in set (0.00 sec)
```

<br>

### 演習16　（難易度：★☆☆）

フリマサイトを活用するため自分のアカウントを新規登録します。次の情報をもとにユーザマスタにデータを追加してください。

- ユーザID: **9**
- メールアドレス: **[名字半角英字]@example.com**
- パスワード: **[名字半角英字]**
- ニックネーム: **任意のネーム**
- 地域: **任意の都道府県名**

**＜期待結果＞**　※データ追加後に検索した結果

```sql
+----+--------------------+----------+----------+--------+
| id | email              | password | nickname | region |
+----+--------------------+----------+----------+--------+
|  9 | sakura@example.com | sakura   | さくら   | 東京都 |
+----+--------------------+----------+----------+--------+
1 row in set (0.00 sec)
```

<br>

### 演習17　（難易度：★☆☆）

作成したアカウントで商品を出品します。次の情報をもとに商品テーブルにデータを追加してください。

- 商品ID: **16**
- 商品名: **任意の商品名**
- 価格: **任意の価格**
- 状態: **S**（新品同様）
- 中カテゴリID: **任意の中カテゴリID**
- 出品者ユーザID: **9**

**＜期待結果＞**　※データ追加後に検索した結果

```sql
+----+----------------------+-------+-------+----------+------------+-----------+----------+-------------+---------------------+
| id | name                 | price | state | m_cat_id | public_flg | seller_id | buyer_id | purchase_dt | updated_dt          |
+----+----------------------+-------+-------+----------+------------+-----------+----------+-------------+---------------------+
| 16 | 自家製スマートフォン |  8000 | S     |        3 |          1 |         9 |     NULL | NULL        | 2023-05-01 17:46:04 |
+----+----------------------+-------+-------+----------+------------+-----------+----------+-------------+---------------------+
1 row in set (0.00 sec)
```

<br>

### 演習18　（難易度：★★☆）

出品した商品をよく確認したところ商品に少々傷があったことが判明しました。対象の商品の価格と状態を次のように更新してください。

- 価格: **現在の価格からいくらか値引いた価格**
- 状態: **B**（目立った傷や汚れなし）

**＜期待結果＞**　※データ更新後に検索した結果

```sql
+----+----------------------+-------+-------+----------+------------+-----------+----------+-------------+---------------------+
| id | name                 | price | state | m_cat_id | public_flg | seller_id | buyer_id | purchase_dt | updated_dt          |
+----+----------------------+-------+-------+----------+------------+-----------+----------+-------------+---------------------+
| 16 | 自家製スマートフォン |  5000 | B     |        3 |          1 |         9 |     NULL | NULL        | 2023-05-01 17:54:49 |
+----+----------------------+-------+-------+----------+------------+-----------+----------+-------------+---------------------+
1 row in set (0.00 sec)
```

<br>

### 演習19　（難易度：★★☆）

出品した商品に対して、わらびさん（ユーザID = 3）とかんころさん（ユーザID = 6）がいいねしてくれました。いいねテーブルに2件のデータを登録し、対象商品のいいね件数を表示してください。また、いいねしてくれたユーザのニックネームを一覧表示してください。

**＜期待結果＞**　※データ追加後に検索した結果

```sql
+----------+
| count(*) |
+----------+
|        2 |
+----------+
1 row in set (0.00 sec)
```

```sql
+----------+
| nickname |
+----------+
| わらび   |
| かんころ |
+----------+
2 rows in set (0.00 sec)
```

<br>

### 演習20　（難易度：★☆☆）

かんころさん（ユーザID = 6）が出品した商品に対するいいねを取り消しました。いいねテーブルからデータを削除してください。

**＜期待結果＞**　※データ削除後に、対象商品に対するいいねデータを検索した結果

```sql
+---------+---------+
| item_id | user_id |
+---------+---------+
|      16 |       3 |
+---------+---------+
1 row in set (0.00 sec)
```

<br>

### 演習21　（難易度：★★☆）

わらびさん（ユーザID = 3）が出品した商品を購入しました。商品テーブルを適切に更新してください。

**＜期待結果＞**　※データ更新後に検索した結果

```sql
+----+----------------------+-------+-------+----------+------------+-----------+----------+---------------------+---------------------+
| id | name                 | price | state | m_cat_id | public_flg | seller_id | buyer_id | purchase_dt         | updated_dt          |
+----+----------------------+-------+-------+----------+------------+-----------+----------+---------------------+---------------------+
| 16 | 自家製スマートフォン |  5000 | B     |        3 |          1 |         9 |        3 | 2023-05-01 19:24:42 | 2023-05-01 19:24:42 |
+----+----------------------+-------+-------+----------+------------+-----------+----------+---------------------+---------------------+
```

<br>

### 演習22　（難易度：★★★）

公開中で、まだ購入されていない商品の商品情報の商品ID、商品名、いいね件数を、いいね件数の降順に検索してください。

**＜期待結果＞**

```sql
+----+---------------------------------------------+------------+
| id | item_name                                   | good_count |
+----+---------------------------------------------+------------+
|  6 | Javaプログラミング入門 第3版                |          5 |
| 10 | ミラーレス一眼カメラ K02X                   |          4 |
|  1 | ノートPC KroBook メモリ32GB SSD512GB        |          3 |
|  8 | 受講者Xの健診                               |          3 |
| 13 | なぜSQLが使われるのか 第12版                |          3 |
|  2 | 実践SQL                                     |          2 |
|  3 | レンズ 一眼レフカメラ用 50mm F1.4           |          2 |
| 14 | ノートパソコン SiroBook メモリ32GB SSD256GB |          2 |
| 11 | 新！Javaのすべてがわかる本                  |          1 |
+----+---------------------------------------------+------------+
9 rows in set (0.00 sec)
```

<br>

### 演習23　（難易度：★★☆）

管理者としてカテゴリマスタを編集します。次のように各マスタにデータを追加してください。その際、1つのトランザクションとして考え、すべての追加処理が正常に完了したタイミングで確定します。

- 大カテゴリマスタ
    - ID: **4**
    - 大カテゴリ名: **ファッション**
- 中カテゴリマスタ
    - 1件目
        - ID: **10**
        - 大カテゴリ名: **アウター**
    - 2件目
        - ID: **11**
        - 大カテゴリ名: **パンツ**
    - 3件目
        - ID: **12**
        - 大カテゴリ名: **靴**

> データを登録したら確定する前に別のコマンドラインクライアントでデータがまだ登録されていないことを確認しましょう。

<br>

**＜期待結果＞**　※データ追加後に検索した結果

```sql
+----+-----------------+
| id | name            |
+----+-----------------+
|  1 | 電子機器        |
|  2 | 書籍            |
|  3 | 文房具/事務用品 |
|  4 | ファッション    |
+----+-----------------+
4 rows in set (0.00 sec)

+----+-------------------------+----------+
| id | name                    | l_cat_id |
+----+-------------------------+----------+
|  1 | コンピュータ機器        |        1 |
|  2 | カメラ                  |        1 |
|  3 | スマートフォン/携帯電話 |        1 |
|  4 | 文学/小説               |        2 |
|  5 | コンピュータ/IT         |        2 |
|  6 | ビジネス/経済           |        2 |
|  7 | 漫画                    |        2 |
|  8 | 筆記具                  |        3 |
|  9 | ノート/メモ帳           |        3 |
| 10 | アウター                |        4 |
| 11 | パンツ                  |        4 |
| 12 | 靴                      |        4 |
+----+-------------------------+----------+
12 rows in set (0.00 sec)
```

<br><br>