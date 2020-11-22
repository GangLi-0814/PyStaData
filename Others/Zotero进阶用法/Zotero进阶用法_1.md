## Zotero 作者名字按西文的方式显示，如何调整为中式？

https://www.zhihu.com/question/58599043

第220至223行
```
				else {
					// Chinese name. first character is last name, the rest are first name
					// creator.firstName = creator.lastName.substr(1);
					// creator.lastName = creator.lastName.charAt(0);
					creator.firstName = "";
				}
			}
```

## 自动重命名文献名

https://mp.weixin.qq.com/s?__biz=MzAxNzgyMDg0MQ==&mid=2650457422&idx=1&sn=0e5661e81efc08b1f716f1659ddbe87f&scene=21#wechat_redirect

http://zotfile.com/index.html#changelog

https://github.com/jlegewie/zotfile

## 一份文档只能显示一种样式

手动修改，后续将不会自动更新


## 抓取知网中文文献元数据识别
https://zhuanlan.zhihu.com/p/165373851

原理方面，它是通过文献的文件名进行识别和数据库匹配的（不同于Zotero自带的英文文献抓取原理），而且支持PDF和CAJ两种格式。

具体来说，你的文件名需要是以下4种格式之一。

```
title_author.pdf/caj
title.pdf/caj
titlePart1_titlePart2_author.pdf/caj
titlePart1_titlePart2.pdf/caj
```

且author的汉字姓名为4字以内。

这里还要提醒一下，由于Jasminum插件是通过文件名来识别的，因此如果文件名不符合上述四种格式是无法识别的。

不过这也代表着：如果你从其他中文数据库（万方）下载了一篇中文文献，且碰巧该文献在知网中也有，那么只要该文献的名称符合上述四种格式，也是可以成功抓取元数据的（亲测）。

以上就是对Jasminum插件的知网中文文献元数据识别功能的介绍，下面介绍一下该插件的第二个功能：作者姓名的拆分或合并。

## 修改为默认经典模式

打开Zotero的Preferences-->Cite-->Word Processors，然后勾选Use classic Add Citation dialog

## 修改CSL样式
https://www.zotero.org/support/zh/dev/citation_styles/style_editing_step-by-step


## 显示文章引用量的插件
https://github.com/MaxKuehn/zotero-scholar-citations

## 一次性抓取学者的成果

##  使用QuickLook预览文件

https://www.jianshu.com/p/71042f2fdd78

https://zhuanlan.zhihu.com/p/66750345


## 进阶指南
https://www.pianshen.com/article/55691854649/

## citation style language(CSL)

https://www.zotero.org/support/zh/dev/citation_styles/style_editing_step-by-step

2. 参考文献索引的格式化
   常见索引只有两种格式：数字 (number) 与作者年代 (author-year)，这也是csl的一种分类的方式。

但是，对于作者年代格式，需要多交代一句，一般使用作者年格式的期刊均有这样的要求：

句子中提到某个人时(即人名充当句子主谓成分时)，索引写做 author(year)；
引文对整个句子解释时(即人名不充当句子主谓成分时)，索引写做 (author year)。
本文建议的处理是，在 Word 的 Zotero 选项卡中，点击 "Add/Edit Citation"。在弹出的索引编辑器中勾选

[x]略去作者/Suppres Author
于是生成一个 (year) 格式的索引，author 则直接写入正文。



基于GB/T 7714 2015(author-date, Chinese)

替换文件：显示全部作者信息