---
layout: post
categories: blog
language: japanese
name: Jekyllにはてなスター導入した
tags: Jekyll
keywords: Jekyll, はてなスター
relations:
  - ranking_plugin
  - ToJekyll
---

承認欲求を満たすためにはてなスターを導入した。

<div class="hatena-star"><a href="{{ site.url }}{{ page.url}}" style="display:none;">hatena</a></div>

手順は[はてなスター日記](http://d.hatena.ne.jp/hatenastar/20070707)の通りで、headなど任意の場所で以下のコードを読み込む。

{% highlight html %}
<script type="text/javascript" src="http://s.hatena.ne.jp/js/HatenaStar.js"></script>
<script type="text/javascript">
    Hatena.Star.Token = 'YOUR_TOKEN';
    Hatena.Star.EntryLoader.headerTagAndClassName = ['div','hatena-star'];
</script>
{% endhighlight %}

EntryLoader.headerTagAndClassNameにaタグを内包するDOMを指定すると、その場所にリンク先のはてなスターが表示される。

ページ内のどこでも設置できるようにしたかったので、ハイパーリンクを設置した上で文字はdisplay:none;で消すという黒魔術を使ってみた。

{% highlight html %}
<div class="hatena-star">
    <a href="PAGE_URL" style="display:none;">hatena</a>
</div>
{% endhighlight %}

はてなスターがあるとどのエントリが盛り上がっているか視覚的に分かって便利。

<img src="https://dl.dropboxusercontent.com/u/12208857/img/ss_hatena_star.png" class="image-on-frame">
