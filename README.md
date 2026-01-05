# らんてくんのブログ

Rails 7.1 + PostgreSQL + Tailwind CSSで構築した個人ブログサービス

## 機能

- 記事一覧・詳細表示（公開）
- 記事の投稿・編集・削除（管理画面 / Basic認証）
- Markdownレンダリング対応
- プロフィールページ

## ローカル開発

### 必要なもの

- Docker
- Docker Compose

### 起動

```bash
# 初回起動
docker compose build
docker compose run --rm web rails db:create db:migrate
docker compose up

# 2回目以降
docker compose up
```

http://localhost:3000 でアクセス

### 管理画面

- URL: http://localhost:3000/admin/posts
- ユーザー名: `admin`
- パスワード: `password`

## デプロイ（Render + Neon）

### 1. Neonでデータベース作成

1. [Neon](https://neon.tech) でアカウント作成
2. 新しいプロジェクトを作成
3. Connection string（`postgres://...`）をコピー

### 2. Renderでデプロイ

1. [Render](https://render.com) でアカウント作成
2. 「New +」→「Web Service」を選択
3. GitHubリポジトリを接続
4. 以下を設定：
   - **Name**: runtekun-blog（任意）
   - **Runtime**: Ruby
   - **Build Command**: `./bin/render-build.sh`
   - **Start Command**: `bundle exec puma -C config/puma.rb`

5. 環境変数を設定：
   | Key | Value |
   |-----|-------|
   | `DATABASE_URL` | Neonの接続文字列 |
   | `RAILS_MASTER_KEY` | `config/master.key`の内容 |
   | `BLOG_USER` | 管理画面のユーザー名 |
   | `BLOG_PASSWORD` | 管理画面のパスワード |

6. 「Create Web Service」をクリック

### Blueprint（自動デプロイ）

`render.yaml`を使用して自動デプロイも可能：

1. Renderダッシュボードで「New +」→「Blueprint」
2. リポジトリを選択
3. 環境変数を設定

## 技術スタック

- Ruby 3.2
- Rails 7.1
- PostgreSQL
- Tailwind CSS
- Redcarpet（Markdown）
