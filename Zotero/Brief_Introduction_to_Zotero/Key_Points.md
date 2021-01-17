### 更改 translators 下载知网文献

问题：Connector下载知网文献失败

https://github.com/l0o0/translators_CN



近期知网进行了改版升级，很多粉丝反映Zotero Connector无法抓取知网文献了！

那么，你该更新一下知网的Zotero translator了！

访问中文Zotero translators的**GitHub主页**[1]，下载最新的`CNKI.js`。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNUib46m6Z9Z5yHiaLz6cUfE43TAsH4pzKpS6TbQCdOI9AjefYuGicymibm3abF6mkicQzG6w0EoRc1YjWw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)下载CNKI.js

然后，进入Zotero的首选项，点击**Show Data Directory**进入Zotero的数据目录。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNUib46m6Z9Z5yHiaLz6cUfE43ytAtGYeGCr5km1xcFTVkRH3YLBB7xU33qvbwQ7TX9ewYu5iba6y3eaQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)找到Zotero数据目录

进入translators文件夹。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNUib46m6Z9Z5yHiaLz6cUfE43AYvDefPDJ1WkCcOcoZtBR30UkHhlicDf94Jd5Jst0QSnfBlbyOYlslg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)进入translatros文件夹

将从GitHub下载的`CNKI.js`拷贝到该目录进行覆盖。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNUib46m6Z9Z5yHiaLz6cUfE43yEKHB8P3n9eY6o7RbhzUJrvYqbOEAgcIVgUPdk9yiazIan63QGTh7AQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)替换就的CNKI.js

重启Zotero。

打开浏览器（Chrome、Firefox或者Edge），右击Zotero Connector，选择**扩展选项**。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNUib46m6Z9Z5yHiaLz6cUfE43gctxOS1g7tUtZL2N5OLtsxaqXkQsiaPmFBFJe7zNeiboktoDiaM6eSjibQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)点击扩展选项

在Advanced中，点击**Update Translators**。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNUib46m6Z9Z5yHiaLz6cUfE43vou9lMic2KSYO5liabrlcU1gmtjL5ib7RE7SupGH1jNhkeCBRsL5pbGAQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)更新translators

重启浏览器。

至此就会发现Zotero Connector能够正常抓取知网的文献了！

我是在域名`https://www.cnki.net`内进行测试的，结果如下。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNUib46m6Z9Z5yHiaLz6cUfE43wxEaNUk2HaT7OroPIJLRKky5cxwibNHhPv9YgdTuChe5mUfdiaiaHjVzw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)测试结果

### Zotero + Sci-hub

PDF resolvers的设置在Zotero的Config Editor中。

我们打开Zotero的首选项，进入`Advanced-->Config Editor`。👇

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNW1boWJVZEKgTxr1LJum7jntkdZCnw95fwINcSr76JzJwszLicQeOBlUBWFlHrM2Sia8ju6QORiba4Cw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

搜索`extensions.zotero.findPDFs.resolvers`，如下。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNW1boWJVZEKgTxr1LJum7jn2V21ccTopCh14UJ4Qww2KmpKsIs7BiabmzXsRBGQcKibL4AQia3SmZoHQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

双击`extensions.zotero.findPDFs.resolvers`，默认情况下是只有一对`[]`。

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNW1boWJVZEKgTxr1LJum7jnybibYPFMSFQOqymRQTDgEewcUB1y1WPcgxxvoUVbaWAjKDmcfNIZ74w/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

删除`[]`，并将以下代码粘贴进去。

```
{
    "name":"Sci-Hub",
    "method":"GET",
    "url":"https://sci-hub.ren/{doi}",
    "mode":"html",
    "selector":"#pdf",
    "attribute":"src",
    "automatic":true
}
```

然后点击OK。👇

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNW1boWJVZEKgTxr1LJum7jnqgrqabIvcAGGNUF01ItH4aOAHIQg7CLiaoDGpbjalQe3NkapdAvOu9g/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

到此就成功将Sci-Hub配置为PDF解析器了，也就是说替代了默认的Unpaywall。

现在，无需重启Zotero，即可调用Sci-Hub免费下载文献了。

这里顺便提三点：

1. 在`"url":"https://sci-hub.ren/{doi}"`中，目前可用的域名有`.tw`、`.ren`、`.si`、`.shop`，大家可以挑选其中一个，哪个用起来体验更好就用哪个。（当然，由于Sci-Hub经常更换域名，保不准改天哪个域名就挂了，或者有新的域名出来，因此此处的代码未来也会根据需要进行更新）
2. 从`"url":"https://sci-hub.ren/{doi}"`还能看到一点。由于Sci-Hub是通过`doi`下载文献的，因此该PDF解析器也需要doi。也就说你的文献必须要有doi，如果doi是空缺的，便无法通过PDF解析器免费下载文献。幸运的是，对于缺失doi的文献，我们可以通过插件**zotero-shortdoi**[5]插件一键抓取doi（参考文章[zotero-shortdoi + Sci-Hub，让99%的文献都能被免费下载！](https://mp.weixin.qq.com/s?__biz=MzAxNzgyMDg0MQ==&mid=2650457478&idx=1&sn=86ec568804dddd33825966548ab0c7ad&scene=21#wechat_redirect)）。
3. `"automatic":true`，如果设置为true，Zotero会自动下载保存到Zotero中的文献的PDF。比如你用Zotero Connector保存了一些文献到Zotero，它便会自动帮你从Sci-Hub下载文献，并附在相应文献条目下。如果你不需要自动下载，可以设置为`"automatic":false`。

使用方法前面介绍过，主要有两种：

#### 第一种：Zotero Connector

通过Zotero Connector保存的文献，会自动下载PDF，无需任何操作。（看不到进度条，下载速度取决于网速）

#### 第二种：Find Available PDF

选中单篇或者多篇文献，手动点击右键菜单中的`Find Available PDF`，会弹出单独的窗口显示下载进度。同样，下载速度取决于网络速度。👇

![图片](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNW1boWJVZEKgTxr1LJum7jnz00SicEeAyJw6I4VUjpgkLaEQ50eUya3lkAGT2JudpdFbz50vYBmy0w/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

关于`下载速度取决于网络速度`有下面两点需要注意；

- 如果你未开启任何网络加速器（比如梯z），即正常使用网络，可以认为Find Available PDF的进度接近你手动从Sci-Hub下载文献的速度。大家应该都体验过，不开启加速器的情况下，Sci-Hub的访问速度还是比较慢的，甚至有时候PDF加载不出来。
- 假如你开启了加速器，推荐使用全局代理模式，而不是PAC模式，因为两种情况下Find Available PDF的进度差异比较大（当然如果你不介意下载速度，使用PAC模式也是可以的）。不过提醒一下，下载完文献，记得切回到PAC模式，因为全局模式下Zotero无法同步文献到坚果云。

### GB/T 7714 

- 何为GB/T

- 默认GB的问题

首先以期刊论文为例。通过调用Zotero的“Zotero Style Preview”窗口，**我将自己之前修改过的2005版和刚刚修改的2015版并排对比。**

![img](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNWEbYDt2PGias1s5XdZOGHbrpHcZD2uzWRRBnqibibEtnibVQhyrAjfN8Hs5CGykJWFEOOMKvU3PKQSbg/640?wx_fmt=png)

如上图所示，上面的是2005版的，下面的是2015版的，可以看出对于期刊论文[J]而言，所做的调整主要在作者姓名的缩写方面。

**可以看到，在2015版中中国著者的姓改为所有字母必须大写，名字则取首字母并大写。**

**其实GB/T 7714-2015版不仅对中国著者的姓名缩写进行了重新规范，对外国著者的姓名缩写规范同样了进行说明。**我们一起来看下GB/T 7714-2015版国标文件是如何描述的。

**关于著录规则的修改**

1）关于个人著者的著录，将“其姓全部著录，而名可以缩写为首字母”修改为**“其姓全部著录，字母全大写，名可缩写为首字母”**，**“缩写名后省略缩写点”**。这里增加了姓的字母全大写的要求，举几个例子。

**示例1：EINSTEIN A 原题：Albert Einstein**

**示例2：WILLIAMS-ELLIS A 原题：Amabel Williams-Ellis**

**示例3：DE MORGAN A 原题：Augustus De Morgan**



2）关于**中国著者**汉语拼音人名的著录，将“用汉语拼音书写的中国著者姓名不得缩写”修改为**“用汉语拼音书写的人名，姓全大写，其名可缩写，取每个汉字拼音的首字母”**。例如：

**原题：Chen Haoyuan 可以著录为CHEN Haoyuan，也可以著录为CHEN H Y，但不应著录为CHEN H，更不得著录为H Y CHEN。**

看完上面的“官方原版”描述，大家应该更加明白新版本是如何改动的了。

**不过可能有人会发现一个问题，按照2015版的官方描述，对于我新修改的2015版Zotero参考文献格式，尽管在中国著者的姓上做到字母全大写了，但是对于有两个字的名字却缩写为单个大写首字母了。**

还是上面的例子，按照新国标，Chen Haoyuan可以著录为CHEN H Y，但不可以著录为CHEN H，然而我修改的2015版csl文件却著录成CHEN H了，那么是不是有问题呢？

**其实不然，主要是因为Zotero的参考文献作者排版是依据下方的Author的值来的。**

![img](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNWEbYDt2PGias1s5XdZOGHbrjcfEJMxzUibaib0SicyVgZeYFesQkGomswmiakhkRNjN5ibVAHx8KegdolQ/640?wx_fmt=png)

如果Author的值是上图的Chen Haoyuan，则排版结果是CHEN H，如下。

![img](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNWEbYDt2PGias1s5XdZOGHbrTkhC5y4iau6bp8l3DxOcqIaleOajebiatPB5tx6ibyhyicUicibaEk0ZBtXQ/640?wx_fmt=png)

如果Author的值是Chen Hao Yuan，

![img](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNWEbYDt2PGias1s5XdZOGHbrNLRwfIIsafXcUU807998uvMwYbF6QMbzjG6IOicesZWDJQElrqLNliaQ/640?wx_fmt=png)



则排版结果是CHEN H Y，如下。

![img](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNWEbYDt2PGias1s5XdZOGHbrb9EetWibWTlpz9XicZoblPFwHIHBktsQNXYibYbY04JWERtGLJcbNNySA/640?wx_fmt=png)

**所以问题很明了了，由于Zotero中每篇文献的Author值都是从期刊网站或者数据库中提取出来的，期刊网站或者数据库中写的格式是Chen Haoyuan，那么Zotero自然把Haoyuan当成一个整体，不会那么智能的知道Haoyuan可能是Hao Yuan，也就只能排版成CHEN H而不是CHEN H Y了。**

那么，这究竟会不会成为一个问题呢？为此，我上网看了下几个知名的中文期刊的排版格式，我发现就算是两个字的名，也只是取了一个大写字母。

**所以，大家不用担心，直接采用我新修改的2015版csl文件即可。除非你愿意一个个把Haoyuan改为Hao Yuan...如果是上百篇文献，那岂不是累死！**

**会议论文[C]排版**

看一个会议论文的例子，如下。

![img](https://mmbiz.qpic.cn/mmbiz_png/xGvHpjh4rNWEbYDt2PGias1s5XdZOGHbrqJNGxqnibTE21INEIYqb6zZdJ7ZDtvG4ImjMIocSrWgy1apL8q7UH0Q/640?wx_fmt=png)

可以看到2015版相比于2005版，有一个**“[C]//.”-->“[C]//”**的变化，即删除了那个点**.**。

其他地方，新修改的2015版相比于2005版没有变化。所以正如大家看到的，调整的地方非常少，主要是著录者的缩写方式。

- 修复
