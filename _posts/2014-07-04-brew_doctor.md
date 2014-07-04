---
layout: post
categories: blog
language: japanese
room: coffee
name: brew doctorのwarningを解決する
tags: Infrastructure
keywords: homebrew, brew, doctor, pyenv
---

brew doctorコマンドで表示されるWarningを順番に解決しました。基本的には指示通りに解決していけばよいのですが、Warning2 pyenvとの干渉が厄介でした。

#### Warning1

{% highlight bash %}
Warning: Some directories in /usr/local/share/man aren't writable.
This can happen if you "sudo make install" software that isn't managed
by Homebrew. If a brew tries to add locale information to one of these
directories, then the install will fail during the link step.
You should probably `chown` them:

    /usr/local/share/man/de
    /usr/local/share/man/de/man1
{% endhighlight %}

一部のディレクトリの所有者がbrewを使うユーザになっていない問題。chownコマンドで所有者を変更します。

{% highlight bash %}
$ sudo chown -R $USER /usr/local/share/man/de
{% endhighlight %}

#### Warning2

{% highlight bash %}
Warning: "config" scripts exist outside your system or Homebrew directories.
`./configure` scripts often look for *-config scripts to determine if
software packages are installed, and what additional flags to use when
compiling and linking.

Having additional scripts in your path can confuse software installed via
Homebrew if the config script overrides a system or Homebrew provided
script of the same name. We found the following "config" scripts:

    /Users/shoya/.pyenv/shims/python-config
    /Users/shoya/.pyenv/shims/python2-config
    /Users/shoya/.pyenv/shims/python2.7-config
{% endhighlight %}

homebrewの管理外かつPATHが通っているところにconfigスクリプトが存在する問題。深刻な問題ではないようなので、このWarningが表示されないよう回避する方向で。brewコマンドを実行するときだけ~/.pyenv/shims/をPATHから取り除くエイリアスを.bashrcに追記した。

{% highlight bash %}
alias brew="env PATH=${PATH/\/Users\/${USER}\/\.pyenv\/shims:?/} brew"
{% endhighlight %}

参考:[phpenv入れてる時brew doctorしたら出るWarning消した](http://qiita.com/takc923/items/45386905f70fde9af0e7)

#### Warning3

{% highlight bash %}
Warning: Some directories in your path end in a slash.
Directories in your path should not end in a slash. This can break other
doctor checks. The following directories should be edited:
    /Applications/MacVim.app/Contents/MacOS/    /Users/shoya/software/android-ndk/    /Users/shoya/software/android-sdk/platform-tools/
{% endhighlight %}

PATHが/(スラッシュ)で終わるのはよくないらしい。.bashrcを編集してそれぞれ最後のスラッシュを取り除きました。

#### Warning4

{% highlight bash %}
Warning: /usr/bin occurs before /usr/local/bin
This means that system-provided programs will be used instead of those
provided by Homebrew. The following tools exist at both paths:

    git
    git-cvsserver
    git-receive-pack
    git-shell
    git-upload-archive
    git-upload-pack

Consider setting your PATH so that /usr/local/bin
occurs before /usr/bin. Here is a one-liner:
    echo export PATH='/usr/local/bin:$PATH' >> ~/.bash_profile
{% endhighlight %}

PATHの順番がよくない。PATHは前方に書かれてあるものが優先されるので、bashrcを見てPATH=(追加するPATH):$PATHの形になっていないものを修正しました。

#### Warning5

{% highlight bash %}
Warning: Your Homebrew is outdated.
You haven't updated for at least 24 hours, this is a long time in brewland!
To update Homebrew, run `brew update`.
{% endhighlight %}

homebrewをアップデートします。

{% highlight bash %}
$ brew update
{% endhighlight %}

#### すべてのWarningを取り除いたので

{% highlight bash %}
$ brew doctor
>> Your system is ready to brew.
{% endhighlight %}

診断結果が正常になりました。めでたい。
