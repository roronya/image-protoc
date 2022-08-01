# image-protoc

## 依存

- [Task](https://taskfile.dev)
- [Docker](https://www.docker.com)

## 使い方

### ソースコードとドキュメントの自動生成

```shell
$ task docker-image-build
$ task protoc-build
```

## Taskfileに書くもの、Dockerfileに書くもの

Dockerfileに書くものは、protocプラグイン(protoc-gen-*)を インストールするためのロジック。
プラグインはインストール方法がプラグインごとに異なるので、コンテナ化しておくと再現性が高い開発環境を作れる。

Taskfileに書くものは、 thirdpartyのprotoファイルを取得するためのロジックと、protocを実行しコードやドキュメントを生成するロジック。
protoファイルはローカルに持っていたほうが、開発時にIntteliJに設定することで補完が効くし、定義も確認できるので開発しやすい。

Dockerコンテナはピュアなprotocランタイムとして機能させることで、protocにプラグインをインストールすることで色んな仕事をさせやすくする。
そのぶんだけ、protocコマンドに渡す引数は複雑になってしまうが、Taskfileのジョブ化することで緩和する。
