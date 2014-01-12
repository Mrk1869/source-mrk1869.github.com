---
layout: post
categories: blog
language: japanese
room: coffee
name: Hello, World
tags: Note
keywords: Jekyll, ブログ, Mrk1869
---

jekyllで書くブログのテストです。<br>
シンタックスハイライトのテスト

{% highlight ruby %}
class Person
  def initialize(name)
      @name = name
  end

  def hello
      "Hello, friend!\nMy name is #{@name}!"
  end
end

mrk1869 = Person.new('Mrk1869')
puts mrk1869.hello

# >> Hello, friend!
# >> My name is Mrk1869!
{% endhighlight %}
