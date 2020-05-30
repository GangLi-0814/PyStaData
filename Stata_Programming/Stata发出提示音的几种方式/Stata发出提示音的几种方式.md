
# 提出问题

在做一些耗时较长或者调试程序时，有没有想过如果程序运行完可以发出提示音？今天这篇文章就来聊下我目前知道让 Stata 发出提示音的几种方法。**声明一下，我是在 Windows 10 (64-bit) + Stata/MP 16 + Python 3.7 环境下运行的代码**，在不同系统和版本的程序下运行可能不太顺畅，如果你用自己的环境玩起来不太顺畅，就放弃吧，当成 tip 了解下就好，如果实在有兴趣，可以自行搜索或者与我交流。


三种方法分别为内置命令 `beep` 、调用 `Beep.exe` 程序和调用 Python 的 `winsound` 模块值得探索，`winsound` 中的 `PlaySound` 函数可以播放音乐，想着可以结合爬虫，爬取排行榜和下载音乐，最终用 Stata 封装一个播放最新排行榜音乐的命令。

关注公众号，后台回复【Beep】获取本文的程序安装包、代码和其他文件。

# 实现过程

## 内置 `beep` 命令

在 Stata 命令窗口输入 `beep` 即可，可以很方便的放在程序里面起到提示作用，比如下面的用法，程序运行到 50% 的时候发出提示音。当然，还有更多的用途，可以根据你的 workflow 加以利用。

```Stata
forvalues i = 0(5)100{
	dis "程序已运行 `i' %"
	if `i' == 50{
		beep
		dis in y "提醒一下"
	}
	sleep 300
}
```
## 调用 Beep 程序

> Beep.exe is a tiny Windows command line utility that uses the internal PC speaker to make a sound. This can be useful in situations when you do not have a sound card or speakers are not connected or turned on.

使用前需要简单配置：前往 [RL Vision](http://www.rlvision.com)  下载`Beep.exe` 程序（40KB），之后是程序路径管理，有两个选择：

- 将 `Beep.exe` 放在当前路径，这样 `Beep.exe` 随路径走才能生效；
- 将 `Beep.exe` 加入环境环境变量（环境变量的配置见附录），这样一次配置后面就可以直接调用了，加入环境变量后重启 Stata 才能生效。

在把程序路径配置好之后，使用 `{shell|!}` 或者 `winexec` 就可以使用:

```Stata
shell Beep
!Beep
winexec Beep
```
`Beep` 还有一些参数可以使用，功能如下：

```Shell
 -- Usage --

  Beep.exe {tone duration [/s sleep]} {...} [/r repeat] [/d]

    tone       Tone to play in Hz
    duration   Time in Ms to play tone
    sleep      Time in Ms to sleep after previous tone (optional)
  
      * These 3 arguments can be repeated to play multiple tones.  
      * Time is measured in milliseconds (Ms). 1000 Ms = 1 second.
  
    repeat    Number of times to play entire sequence. (optional)
      
      * Default is to play only once.
      * Enter 0 for unlimited repeats (Break with Ctrl+C)

    /d        Print on screen what is playing (optional)

  Note: If you don't enter any arguments, a "notification" 
  sound is played.

 -- Examples --

  Notification (the default sound):
    
    beep.exe 240 10 /s 50 280 10 /s 50 340 10

  Alarm:
  
    beep.exe 300 15 310 15 320 15 330 15 340 15 350 15 360 15 370 15 380 15 390 15 400 15 390 15 380 15 370 15 360 15 350 15 340 15 330 15 320 15 310 15 300 15 
```


# 调用 Python 的 `winsound` 库

 Python 的标准库 `winsound` 可以播放 Windows 声音，主要函数和常量如下：

|函数或常量|用法|
|:---:|:---:|
|`winsound.Beep(frequency,duration)`|`frequency`指定声音的频率（赫兹），`duration` 指定持续毫秒数`|
|`winsound.PlaySound(sound, flags)`|`sound`可以是文件名、系统声音别名和音频数据等，其解释取决于`flags`|
|`winsound.MessageBeep(type=MB_OK)`|播放注册表中指定的声音|
|`winsound.SND_FILENAME`|`sound`参数是`wav`文件名。不能和`SND_ALIAS`一起使用|
|`winsound.SND_ALIAS`|`sound` 参数是注册表中的声音关联名称。如果注册表不包含此类名称，则播放系统默认声音|

 此外，还有一些播放次数和选择声音来源的设置，更详细的用法可以参阅官方文档。接下来我们看几个用法：

```Stata
Python:
import winsound 

# 播放 Windows 退出提示音
winsound.PlaySound("SystemExit", winsound.SND_ALIAS)

# 循环、升调
freq = 100
dur = 50
for i in range(0, 10):     
    winsound.Beep(freq, dur)     
    freq += 100
    dur += 80

# 播放自定义音乐
# 注意要是 `wav` 格式
winsound.PlaySound(r'..\Music\ding.wav',winsound.SND_FILENAME)

end
```

# 小结

以上就是我已知让 Stata 发出提示音的几种方法？你还有其他更好的方法吗？可以后台交流。综合来看，如开头说的，调用 Python 标准库 `winsound` 值得探索，可以弄出一些好玩的东西。

# 附录：配置环境变量

在设置中搜索环境变量，之后在编辑账户环境变量中找到 path 点击新建，然后粘贴进 Beep 所在的文件夹，点击确定。随后可以使用 win+R 输入 `cmd` 进入命令行窗口输入 `Beep` 检查是否安装成功，动图演示：

![](./image/环境变量.gif)
