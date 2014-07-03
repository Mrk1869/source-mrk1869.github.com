---
layout: post
categories: blog
language: japanese
room: coffee
name: プロセスが完了しました
tags: Infrastructure
keywords: Mac, ターミナル, プロセスが完了しました, ログイン
---

<img src="https://dl.dropboxusercontent.com/u/12208857/img/terminal01.png" class="image-on-frame-medium">

#### 問題

Macのターミナルが起動しない。起動するとすぐに\[プロセスが完了しました\]と表示される。

#### 原因

ユーザ名が - から始まっている

#### 解決策

ユーザ名を変更する(システム環境設定>ユーザとグループ>詳細オプション)。

**ユーザ名の変更は多くのアプリケーションの動作に影響を及ぼす可能性があります。バックアップをとったのち、慎重に実行してください。**

<img src="https://dl.dropboxusercontent.com/u/12208857/img/terminal02.png" class="image-on-frame-medium">

Macのターミナルが動かないという報告を受けたのだけれど、原因はユーザ名がマイナスから始まっていたことだった。-piyoのようなユーザ名はloginコマンドのプションとして認識されてしまうので(もちろんそんなオプションはない)ターミナルでログインできない。なんだそれ...
