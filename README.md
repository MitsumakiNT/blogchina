# ブログアプリ

## 概要
> ###  このアプリ制作を通して学んだこと
 1. Rails6で実装されたActiontextというテキストエディターを使ってみること　
 2. Activestorageとgem`carrierwave`を用いたサムネイル昨日の実装
 3. gem`devise`を用いたログイン機能の実装
 4. gem`acts-as-taggable-on`を**用いない**タグ機能の実装
 5. scssを使った装飾

## 使用した技術
* 言語: Html/SCSS/Ruby 2.5.1/SQL
* FW:  Ruby on Rails
* DB: MySQL
* デプロイ環境: Heroku

## 制作背景
> ブログアプリを通してフロントからサーバーサイドまでの技術理解を満遍なく深めるために作成した。またgemで機能実装を自動化しない場合、どの程度の工程が必要なのかも学習したいと考えた。


## データベース設計
### Articlesテーブル
|Column|Type|Options|
|------|----|-------|
|title|string||
|body|text||
|status|integer|null: false|
|time|datetime||

### Association
 - has_one_attached :image
 - has_rich_text :content
 - has_many :mapguides, dependent: :destroy
 - has_many :maps, through: :mapguides

### Activestorage_blobsテーブル
|Column|Type|Options|
|------|----|-------|
|key|string|null: false|
|filename|string|null: false|
|content_type|string||
|metadata|text||
|byte_size|bigint|null: false|
|checksum|string|null: false|

### Activestorage_attachmentsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null :false|
|record|references|null: false|
|blob|references|null: false|

### Action_text_rich_textsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|body|text|size: :long|
|record|refernces|null: false, index: false, polymorphic: true|

### Categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|categories|stirng||

### Articles_categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|article_id|integer||
|category_id|integer||

### Mapsテーブル
|Column|Type|Options|
|------|----|-------|
|tag_name|string||

### Mapguidesテーブル
|Column|Type|Options|
|------|----|-------|
|article_id|integer||
|map_id|integer||

