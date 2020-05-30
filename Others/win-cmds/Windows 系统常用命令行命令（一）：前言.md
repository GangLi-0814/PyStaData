Windows 系统常用命令行命令（一）：前言

# 前言

刚接触 Stata 可能对命令行操作不太习惯，其实可以先了解常用的 Windows 命令行命令。不仅可以熟悉命令操作，还可以体验命令行操作的“快感”，提高工作效率。

如果对 Windows 命令行的起源和终端的演变感兴趣，这里有一份微软官网的介绍：[Windows Command-Line: Backgrounder](https://devblogs.microsoft.com/commandline/windows-command-line-backgrounder/)。

# 操作方式

## Windows 控制台

### 命令窗口

使用 `win+R` 快捷键打开 **运行** 对话框，输入 `cmd` 打开控制台命令窗口。也可以通过`cmd /c` 命令 和 `cmd /k` 命令的方式来直接运行命令。其中，`/c` 表示执行完命令后关闭 cmd 窗口；`/k` 表示执行完命令后保留 cmd 窗口。

![命令窗口](https://gitee.com/mudaozzz/win-cmds/raw/master/img/1-2.png)

在指定路径打开命令窗口：在目标路径空白处按住 `Shift` ，然后右键弹出快捷菜单，点击“在此处打开命令行窗口”（或者“在此处打开Powershell窗口”）。

![指定路径下右键选项](https://gitee.com/mudaozzz/win-cmds/raw/master/img/1-3.png)

### 其他技巧
- `command /?` 用于查看 command 命令的帮助说明；
- 中断命令执行：`Ctrl+Z`；
- 使用上下方向键，查看使用过的命令；
- 使用 `Tab` 键补齐命令。


## Stata 使用

Stata 中调用命令行主要有下表三种，不论是在 Command 窗口还是 do-file 中，调用方式是一样的。以打开控制台窗口命令`cmd`为例：

|命令|示例|
|:---:|:---:|
|`!command`|`!cmd`|
|`shell command`|`shell cmd`|
|`winexec command`|`winexec cmd`|