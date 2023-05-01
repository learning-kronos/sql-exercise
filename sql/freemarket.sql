create table user (
    id int primary key,
    email varchar(100) unique not null,
    password varchar(100) not null,
    nickname varchar(50) not null,
    region varchar(30) not null
);

create table l_category (
    id int primary key,
    name varchar(50) unique not null
);

create table m_category (
    id int primary key,
    name varchar(50) unique not null,
    l_cat_id int not null,
    foreign key (l_cat_id) references l_category(id)
);

create table item (
    id int primary key,
    name varchar(50) not null,
    price int not null,
    state varchar(10) not null,
    m_cat_id int,
    public_flg tinyint(1) not null default 1,
    seller_id int not null,
    buyer_id int,
    purchase_dt datetime,
    updated_dt datetime not null default current_timestamp on update current_timestamp,
    foreign key (m_cat_id) references m_category(id),
    foreign key (seller_id) references user(id),
    foreign key (buyer_id) references user(id)
);

create table good (
    item_id int,
    user_id int,
    foreign key (item_id) references item(id),
    foreign key (user_id) references user(id),
    primary key (item_id, user_id)
);

insert into user (id, email, password, nickname, region) values (1, 'ohagi@example.com', 'ohagi', 'おはぎ', '京都府');
insert into user (id, email, password, nickname, region) values (2, 'yomogi@example.com', 'yomogi', 'よもぎ', '鹿児島県');
insert into user (id, email, password, nickname, region) values (3, 'warabi@example.com', 'warabi', 'わらび', '奈良県');
insert into user (id, email, password, nickname, region) values (4, 'abekawa@example.com', 'abekawa', 'あべかわ', '静岡県');
insert into user (id, email, password, nickname, region) values (5, 'kashiwa@example.com', 'kashiwa', 'かしわ', '東京都');
insert into user (id, email, password, nickname, region) values (6, 'kankoro@example.com', 'kankoro', 'かんころ', '長崎県');
insert into user (id, email, password, nickname, region) values (7, 'kuzu@example.com', 'kuzu', 'くず', '東京都');
insert into user (id, email, password, nickname, region) values (8, 'mitarashi@example.com', 'mitarashi', 'みたらし', '岐阜県');

insert into l_category (id, name) values (1, '電子機器');
insert into l_category (id, name) values (2, '書籍');
insert into l_category (id, name) values (3, '文房具/事務用品');

insert into m_category (id, name, l_cat_id) values (1, 'コンピュータ機器', 1);
insert into m_category (id, name, l_cat_id) values (2, 'カメラ', 1);
insert into m_category (id, name, l_cat_id) values (3, 'スマートフォン/携帯電話', 1);
insert into m_category (id, name, l_cat_id) values (4, '文学/小説', 2);
insert into m_category (id, name, l_cat_id) values (5, 'コンピュータ/IT', 2);
insert into m_category (id, name, l_cat_id) values (6, 'ビジネス/経済', 2);
insert into m_category (id, name, l_cat_id) values (7, '漫画', 2);
insert into m_category (id, name, l_cat_id) values (8, '筆記具', 3);
insert into m_category (id, name, l_cat_id) values (9, 'ノート/メモ帳', 3);

insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (1, 'ノートPC KroBook メモリ32GB SSD512GB', 200000, 'A', 1, 1, 5, '2022/05/10 10:18:32');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (2, '実践SQL', 1200, 'D', 5, 1, 7, '2022/06/05 14:23:09');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (3, 'レンズ 一眼レフカメラ用 50mm F1.4', 45000, 'A', 2, 1, 7, '2022/05/15 07:03:54');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (4, '黒いタブレット SIMフリー 64GB', 32000, 'B', 1, 0, 3, '2022/05/19 11:32:11');
insert into item values (5, 'タブレット 9.7インチ シリコンケース', 3800, 'S', 1, 1, 3, 1, '2022/06/22 10:34:56', '2022/05/19 16:51:10');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (6, 'Javaプログラミング入門 第3版', 2800, 'B', 5, 1, 4, '2022/06/10 14:09:49');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (7, '黒い粉', 300, 'S', NULL, 1, 8, '2022/05/25 17:12:44');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (8, '受講者Xの健診', 900, 'A', 4, 1, 1, '2022/05/30 12:45:37');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (9, '消せるボールペン', 300, 'S', 8, 0, 8, '2022/06/04 09:51:56');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (10, 'ミラーレス一眼カメラ K02X', 98000, 'A', 2, 1, 7, '2022/06/08 19:20:54');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (11, '新！Javaのすべてがわかる本', 1500, 'C', 5, 1, 4, '2022/06/08 22:07:08');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (12, 'プレミアム万年筆', 5000, 'S', 8, 1, 3, '2022/06/09 15:43:11');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (13, 'なぜSQLが使われるのか 第12版', 4000, 'S', 5, 1, 1, '2022/06/10 08:12:59');
insert into item (id, name, price, state, m_cat_id, public_flg, seller_id, updated_dt) values (14, 'ノートパソコン SiroBook メモリ32GB SSD256GB', 128000, 'B', 1, 1, 4, '2022/06/15 10:50:38');
insert into item values (15, 'MySQL 8.0 マスター', 800, 'E', 5, 1, 1, 5, '2022/06/28 14:51:06', '2022/06/15 16:20:19');

insert into good values (1, 1);
insert into good values (5, 5);
insert into good values (10, 2);
insert into good values (6, 1);
insert into good values (1, 4);
insert into good values (6, 5);
insert into good values (10, 3);
insert into good values (3, 1);
insert into good values (8, 3);
insert into good values (11, 1);
insert into good values (6, 3);
insert into good values (2, 4);
insert into good values (10, 8);
insert into good values (3, 5);
insert into good values (6, 7);
insert into good values (1, 6);
insert into good values (13, 2);
insert into good values (2, 5);
insert into good values (13, 6);
insert into good values (8, 2);
insert into good values (10, 5);
insert into good values (14, 5);
insert into good values (14, 3);
insert into good values (8, 7);
insert into good values (15, 7);
insert into good values (6, 8);
insert into good values (13, 7);
