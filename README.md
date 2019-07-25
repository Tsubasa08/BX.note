# BX.note

BX.note は Web デザイナー初心者のための SNS です。  
初心者同士で繋がり、有用な情報を共有し合うことで、
さらにレベルアップすることができます。 https://bx-note.herokuapp.com/

### テストアカウント

メールアドレス：kaeru@mail.com  
パスワード：password

## 使用技術

- インフラ
  - Heroku
- データベース
  - PostgreSQL
- モジュールバンドラ
  - Webpacker(gem)
- テスト
  - minitest
- 画像アップロード
  - Active Storage
  - Amazon S3
- メイラー
  - Action Mailer
- Twitter 認証機能
  - omniauth-twitter(gem)
- 検索
  - ransack(gem)
- スクレイピング
  - nokogiri(gem)
- ページネーション
  - kaminari(gem)
- カルーセル
  - slick(jQuery プラグイン)
- UI デザインツール
  - Adobe XD
- プロジェクト管理ツール
  - Trello

## 機能

- ユーザー登録機能
- パスワード再設定機能(メール送信)
- ログイン機能、Twitter によるログイン認証
- 投稿機能全般(CRUD)
- 画像アップロード機能
- いいね機能
- コメント機能
- ページネーション
- フォロー/フォロー解除機能
- スクレイピング機能
- 記事検索機能
- カルーセル

## 開発工程

- 開発手法
  - ウォーターフォール型
- 工程
  1. 要件定義
  2. 外部設計
  3. 内部設計
  4. 実装(テスト駆動開発)
  5. 運用

### 要件定義

- テーマ
  - Web デザイナー初心者のための SNS
- ペルソナ
  - 大学 2 年生、文系男子、Web 制作の勉強を最近始めた
- 目的
  - Web デザイナー初心者に役立つ情報を Web デザイナー初心者同士で共有する → ネットよりも確かな、初心者の生の声

## 環境

- Ruby 2.6.2
- Rails 5.2.3
