
# EC2セットアップ手順書

## 前提条件
- Difyフォルダ一式をEC2インスタンス上にコピーしておくこと
- Amazon EC2 インスタンス必要要件
  - AMI : Amazon Linux 2 AMI
  - Instance type : t3.medium (2vCPU, 4GB MEM が必要)
  - セキュリティグループ : インバウンドルールに HTTP(80) を追加
  - 必要に応じてソース IP の制限等を設定
  - Application Load Balancer (ALB) を利用する場合、ALB のセキュリティグループからのみ通信を制限するように設定（https通信の為の設定）
  - その他は任意です

## 1. スクリプトに実行権限を付与

```bash
chmod +x ./dify/1_setup_EC2.sh
```

### スクリプト内容: 1_setup_EC2.sh
- Dockerのインストールと設定
- Docker Composeのインストール
  ※現時点で最新のバージョン（v2.4.1）をインストールしていますが、将来的に変更が必要な場合は、以下の公式ドキュメントを参照してください。
  [最新のDocker Composeインストール方法はこちら](https://matsuand.github.io/docs.docker.jp.onthefly/compose/install/)
- 再起動で設定反映

## 2. スクリプトの実行

```bash
./dify/1_setup_EC2.sh
```

## 3. DockerとDocker Composeの確認（再起動後）

スクリプトが完了すると、`./dify/1_setup_EC2.sh`の中で自動的に再起動が行われます。再起動後、DockerとDocker Compose（v2.4.1）が正しくインストールされているか確認します。

```bash
docker -v
docker compose version
```

## 4. 次のスクリプトに実行権限を付与

```bash
chmod +x ./dify/2_setup_EC2.sh
```

### スクリプト内容: 2_setup_EC2.sh
- Docker Composeを使ってサービス起動

## 5. 次のスクリプトの実行

```bash
./dify/2_setup_EC2.sh
```

## 6. サービスの起動確認

セットアップが完了したら、ウェブブラウザを使用して、以下のURLにアクセスし、接続確認を行います。

- **ALB（アプリケーションロードバランサー）を使用している場合**  
  以下のURLにアクセスします。  
  ```
  https://{ALB の DNS 名または IP アドレス}/install
  ```

- **直接EC2インスタンスに接続する場合**  
  以下のURLにアクセスします。  
  ```
  http://{EC2 のパブリック DNS 名または IP アドレス}/install
  ```

各設定によってアクセスするURLは異なるため、適切なURLを使用してください。ブラウザにアクセスできれば、サービスが正常に起動していることを確認できます。