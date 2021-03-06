---
title: IE7，你准备好了没？
---
您可以把本篇当做是《与臭虫为友——浏览器补救办法，臭虫以及解决方案 》[三][0] [系][1] [列][2]的第四系列。

其实，对于专职于web标准的人来说，我们在IE7 Beta1的时候就准备好了，XD。不信可以看看[针对IE7的CSS Hack][3]，如果你是沉迷于各种hacks的人，务必务必要看！各位知道我从不转载的作风，所以，给[old9][4]一个机会，狠狠地点击吧 :D

IE7这个版本极度提升了对CSS的支持，外加一个长久以来备受抱怨的透明PNG支持。除了没有[CSS generate content][5]以外，其实没有什么好抱怨的，抛弃hacks的时代真的来临了，条件注释的方式将是您最好的伙伴。实际上，一直以来，在我的项目中，我只有一个`ie6patch.css`（我一直对这个命名引以为豪），是不是需要引入一个`ie7patch.css`？在大部分情况下，已经没有必要的了，我前面说过，IE7对CSS的改进是有目共睹的，但不可避免，作为MS的产品，没有缺陷是卖不出去的 XD。

## 自动清除浮动问题

一个[自动清除浮动][6]最安全的做法是使用 `:after`，而这正是IE7缺少的支持。在IE6中，们使用 `height: 1%` 来达到相同目的。解释一下这条hack的原理吧，`height`的值可以是任意的，它只是用来触发IE特有的[`hasLayout`][7]（没错，还是old9的）,而在IE6中，`height`实际上等同于`min-height`。遗憾的是，IE7已经修正了`height`这个bug。幸运的是，IE的`hasLayout`还存在，我们也可以给高度通过指定一个数值来触发它。IE7新支持的`min-height`可以帮忙。所以，在IE7中，这句可以帮您搞定自动清除浮动的问题：`min-height: 1px;`。（在我看来1px要比1%安全，您随自己的喜好吧）。

如何做？

```css
    * html .wantoclear { height: 1%; } /*ie6*/
    *+html .wantoclear { min-height: 1px; }/*ie7*/
```

这对于小型项目来说可以quick and dirty，但是大型项目中，我个人的建议是，还是使用条件注释的方式吧，在`ie7patch.css`的中只需写 `.wantoclear { min-height: 1px; }`，更方便于维护。

另外，清除浮动的方式有多种，比如使用`overflow`，但实践证明，只有上述方式是**最安全**的。其他方式可以酌情使用。参看：[闭合浮动元素][8]（还是old9！）。总之，您现在看到您的项目页面不能正常显示，十有八九是它导致的，按照我的方法，Get ready for IE7吧 :)

## 百分比宽度问题

这个问题让头痛，从IE5起，到IE7，遗憾的是并没有修正。当您使用百分比作为宽度单位时，IE的计算总是差那么几个像素。在一般应用中，这倒不会导致什么问题。但依靠浮动来布局的话，这确实致命的，因为稍微有1像素的差异，IE不像Firefox, Opera还能让布局保持，它会将另外超出父元素的元素狠狠地甩到下一行中，导致布局的错落。举个简单的例子，假设我们有一堆的`li`元素，我们需要每行放置4个。用百分比的方式来做，则可以一句很简单的`li { float: left; width: 25%; }`搞定，且具有巨大的灵活性。但是IE……wtf...有时候确实正常给你每行排列4个，有时候却只有3个。你看到比你预期的少一个，那就是它计算宽度的误差导致的。

解决方法其实很简单，把宽度减少 0.1% - 0.5%就可以了。就是说，你可以在`ie7patch.css`写上`li { float: left; width: 24.9%; }`。

IE7还存在这么多问题，而且不知道到IE8会不会修正，这就是为什么还需要使用条件注释的原因。

IE7即将通过"高优先级更新"来入侵用户电脑，我们还是提前做好准备吧。

另外，目前的实践经验还不是很多，很多问题尚在发现中，这是一篇不断更新的blog，欢迎大家补充，谢谢。

2006-11-16更新：

根据[Three reasons sites break in Internet Explorer 7][9], 导致IE7出问题的三个可能理由是：

* 在Doctype之前使用了导致IE6使用Quirks mode的XML声明，IE7已经修复这个问题，相同的CSS而不同的渲染模式，因此IE7可能会出问题。
* 网站构建基于大量的hacks，而这些hacks在IE7中已经修复。
* 使用没有判断浏览器版本的条件注释来引入CSS，导致IE7也引入了那些本不该是修复IE7的CSS。

另外，推荐阅读[Internet Explorer 7: Were you ready?][10]。

2006-11-23更新：

推荐阅读：[Wake up and smell the IE7!][11]

[0]: /posts/2006-07-29-working-with-buggy-browsers-1.html
[1]: /posts/2006-07-31-working-with-buggy-browsers-2.html
[2]: /posts/2006-08-20-working-with-buggy-browsers-3.html
[3]: http://old9.blogsome.com/2006/04/29/css-hack-for-ie7/
[4]: http://old9.blogsome.com/
[5]: http://www.w3.org/TR/CSS21/generate.html
[6]: http://www.positioniseverything.net/easyclearing.html
[7]: http://old9.blogsome.com/2006/04/11/onhavinglayout/
[8]: http://old9.blogsome.com/2006/04/21/enclosing-floats/
[9]: http://www.456bereastreet.com/archive/200611/three_reasons_sites_break_in_internet_explorer_7/
[10]: http://www.thinkvitamin.com/features/design/internet-explorer-7-were-you-ready
[11]: http://www.thinkvitamin.com/features/design/wake-up-and-smell-the-ie7
