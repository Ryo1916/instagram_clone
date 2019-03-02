# サブ課題　instagramクローンサイト

- 開発環境：MacOS 10.14.1
- Ruby: 2.5.0
- Rails: 5.1.6

### 実装できた機能
- ユーザ登録、ログイン／ログアウト
- facebookアカウントによるログイン
- 画像投稿機能
- 画像へのいいね機能
- 画像へのコメント機能
- ユーザフォロー機能
- 画像、ユーザの簡易検索機能

### 実装できなかった機能
- ユーザへの通知機能
- モデルテスト以外のRspecによるテスト

# 苦労した点
1.開発関連
- 参考にすべき情報の見極め方
情報の見極めが一番難しかった。ブログやQiitaももちろん参考になるが、もっとも有用なのは公式ドキュメントや書籍であることがよくわかった。

- コミットについて
コミットの粒度、コミットに書くべきコメントの内容を考えるのが難しかった。コミット粒度については以下の記事が参考になった。
<https://qiita.com/jnchito/items/40e0c7d32fde352607be#%E6%A5%B5%E7%AB%AF%E3%81%AB%E5%B0%8F%E3%81%95%E3%81%8B%E3%81%A3%E3%81%9F%E3%82%89>

- herokuからS3へのファイルアップロード
アップロードされたファイル名が一意になるようにするため、初めはアップロードされた時間（秒単位）でファイル名を変換するようにしていた。しかしproduction環境だと、通常バージョンとサムネイルバージョンの保存時刻がずれ、存在しない画像ファイルを参照するようになっていた。これに気づくのに半日以上要してしまった。
[https://qiita.com/tackey/items/ba68ca8489500b7cb739](https://qiita.com/tackey/items/ba68ca8489500b7cb739)  
[https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Create-random-and-unique-filenames-for-all-versioned-files](https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Create-random-and-unique-filenames-for-all-versioned-files)

- Rspecによるテスト
今回初めて本格的にRspecを利用してみたが、結局モデルテストまでしか対応することができなかった。しかし、実際の実装や参考情報などを通して、テストがあると変更に強いテストがかけることもよくわかった。Everyday Railsを一通りやり、体系的に習得できるようにしたい。

2.マネジメント関連
- タスク管理
仕様書に記載されていた要件が漏れないように、各機能ごとにタスクに落とし込んでTrelloで管理していたが、時間が足りずにメール通知機能が実装できなかった。画面カスタマイズにかなり時間を使ってしまったので、今回以降は注意する。また、Trelloの使い方も結構自己流なので、実際に現場ではどのように使われているかも調べてみる。
https://trello.com/b/5WYEXjHh/instagramclone

- 現在の仕事との兼ね合い
これはみなさん大変だと思うが、予期せぬ夜間対応に2度ほど立会いになったりしてこちらの作業時間を確保するのがなかなか大変だった。

# 自慢したい点
 - スタックしてしまった時の対応
いくつかの機能を実装する際、うまくいかなくて何時間も使ってしまうことがあったが、なるべくこだわらずに他の方法で実装するか、QAサイトに質問して後回しにするなど対応をとった。
	- https://stackoverflow.com/questions/54733296/cannot-avoid-activerecordstatementinvalid-pgdatatypemismatch-error-defau
	- https://stackoverflow.com/questions/54783268/how-to-test-file-size-in-rspec
	- https://stackoverflow.com/questions/54839059/extension-whitelist-prevents-fakeravatar-image

- devise, omniauth周りのカスタマイズ
公式ドキュメントを参考にすることで、うまく要件通りのカスタマイズができた。

- 画面カスタマイズ
Railsのブートキャンプなのであまり時間を取るべきところではないが、クローンサイト作成ということなのでなるべく本家に近づけるようにし、Bootstrapによるレスポンシブ対応も行ってみた。荒削りではあるが、結構本家の見た目に近づけることができたと思う。
