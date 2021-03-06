---
title: “书记员”──穷人的TextMate?
---
其实标题起得不好，这篇文章更像是一个软件的评论(review). 但为了我憧憬的TextMate，请原谅我这么做。

如果你和我一样，是[Ruby On Rails][0]（简称RoR, [繁体版][1]）爱好者，那么对[TextMate][2]这个Mac OS X下的编辑器一定不会陌生（事实上，你不能不看到它，因为RoR圣经[Agile Web Development with Rails---Second Edition][3]中，作者公然为这个编辑器打广告──整个Rails团队都在用！）。多少人，为了这个€39的东西买了一台不下 $1200的mac机器……事实上，这也是我的梦想……如果你想知道TextMate的魅力多大，不访看看RoR或者官网上的演示视频。

言归正传，对于目前的我来说，"_有钱Mac，无钱Linux_"是我的哲学，憧憬是我活下去的因素之一，为了活得更长久，先不买mac吧（借口还不算烂吧 XD）……

开源社区是伟大的！我发现了一款编辑器，尽管不敢用"媲美"这个词，但实现了我最喜欢的部分，让我更心安不买mac了。它叫"书记员"，这是我给[Scribes][4]的翻译。

如果你已经看过TextMate的演示视频，不妨在看看我们"书记员"的：[Scribes In Action][5]. 代码自动完成功能是不是很帅？

从"书记员"的[UI][6]上来看，工具栏上真是简洁得不得了，虽然新手可能一下子不知道某些icon的功用（对于一些icon其实是不言而喻的，因为都遵循了**惯例**），但是，这么少的功能，并不会带来多大的记忆负担，上手并使用绰绰有余。

工具栏这么少并不代表"书记员"简单。为何叫"书记员"？专注于文本编辑啊。编辑文本要干嘛？跟键盘打交道，尽量减少鼠标的使用，大量使用快捷键，文本自动完成，这才能提高文本编辑的效率。

快捷键？不错，世界上的编辑器都有快捷键，比如VI。但是，学习这些编辑器的快捷键就跟学习五笔一样痛苦（假如可以叫痛苦的话），你需要持之以恒的练习（我想这些时间是不是可以节省出来做其他事情，让生活更美好）。我们的"书记员"不会让你这么痛苦。

它所有快捷键都是**自我注释**的。首先，操作文件，"书记员"是遵循惯例，CTRL + O打开文件，CTRL + S保存文件，没错，你已经猜到CTRL + Shift + S是另存为。包括查找CTRL + F，替换CTRL + R，这些都没有什么出奇之处，因为这已经成了事实上的标准，创新反而会让人接受不了。这不用学习，自然而然。

对，"书记员"把功力发挥在编辑文本的过程中。如果我告诉你ALT + W选择一个单词， ALT + L选择一行，那么ALT + P选择什么？ W = **W**ord, L = **L**ine, P =? bingo! right, it is **P**aragraph! ALT + P选择了一个句子。那么， ALT + S你还用记忆吗？ 那就是 **S**entence，句子。基本上，把说明书上的快捷键看一轮，练习一轮，就能使用"书记员"给你带来的强大功能了，那么，我们有更多时间追求美好的生活了。

对于需要写代码的我们来说，许多工作都是在重复劳动。我们需要模板，让编辑器帮我们完成重复的工作，比如，我输入`htmlstrict`，编辑器应该能够帮我生成Doctype是XHTML 1.0 Strict的基本模板。提供自动完成的编辑器当然数不胜数，但定制模板的方便性，"书记员"的方式绝对是我见过的最简易的。

先看看"书记员"的代码自动完成方式，假设我有一条这样的规则：

    link: <a href="${URL}">${text}</a>${cursor}

当我在"书记员"里敲下link，按tab键，则会自动生成`<a href=\"URL\">text</a>`的代码，并且光标落在URL处，改写为实际需要的链接即可，再按一下tab，就跳到下一个text处，最后跳到鼠标定义的位置（`${cursor}`），如果定义了的话。

Keep it simple, stupid(KISS)! 强悍的程序不需要注释！因为它们都是自我注释的！没错，"书记员"的模板定制方式是自我注释的。请看这条`link`标签的模板：

```html
<a href="${URL}">${text}</a>${cursor}
```

`${text}`? 很明显，意思是说，自动完成`a`标签后跳到这里进行编辑，编辑完后鼠标(`${cursor}`)跳到最后。很简单明了吧？这样你就可以很方便自己定制自己的模板系统，而且随心所欲，爱干嘛干嘛去，生活多美好哦……

其实这强大的定制性正是我需要的，我可以YY一下TextMate了，呵呵……

更新：[Scribes 0.3 点评][7]

[0]: http://rubyonrails.org/
[1]: http://rubyonrails.org.tw/
[2]: http://www.macromates.com/
[3]: http://www.pragmaticprogrammer.com/titles/rails/index.html
[4]: http://scribes.sourceforge.net/
[5]: http://scribes.sourceforge.net/demo.htm
[6]: http://scribes.sourceforge.net/functions.html
[7]: http://linuxtoy.org/archives/scribes_0_3_review.html
