# pkg

ここでは RPM や DEB などのパッケージ作成用のスクリプトを管理します。

Ubuntu で実行することを想定してます。

## 環境準備

```
$ make env
$ make images
```

## パッケージの作成例

以下のように各プラットフォームごと、各パッケージごとにスクリプトが用意されており、make を実行してパッケージを作成できます。  
作成されたパッケージは、/opt/pkg/[deb|rpm]/xxx/yyy に保存されます。

```
$ cd deb/qemu
$ make 22-amd64-7.2.1
```

## レポのメタデータ作成とレポの公開

以下の make repo で、レポのメタデータ作成が行えます。  
以下の make start で、nginx を起動し、レポを公開できます。

```
$ make repo
$ make start
```

## apt repo の設定例

/etc/apt/sources.list.d/localhost.list

```
deb [trusted=yes] http://localhost/deb/ubuntu/22/amd64/ ./
```

```
$ sudo apt-get update
$ sudo apt-get install qemu=7.2.1-0
```

## yum repo の設定例

/etc/yum.repos.d/localhost.repo

```
[repo]
name=localrepo
baseurl=http://localhost/rpm/rocky/8/x86_64/
enabled=0
gpgcheck=0
```

```
$ sudo yum install ...
```
