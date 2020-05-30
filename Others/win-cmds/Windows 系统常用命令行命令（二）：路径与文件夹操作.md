Windows 系统常用命令行命令（二）：路径与文件夹操作

本节主要介绍路径操作和文件夹操作的命令，包括更换路径、显示目录、创建和删除文件夹。本节命令速览：

|  命令   |      用途      |
| :-----: | :------------: |
|  `cd`   |    更换路径    |
|  `dir`  | 显示路径下内容 |
|  `ls`   | 显示路径下内容 |
| `tree`  |  图示目录结构  |
| `mkdir` |   新建文件夹   |
| `rmdir` |   删除文件夹   |

## `cd` 命令用于切换目录

`cd` 可以显示当前目录，`cd + path` 进入指定的路径（path），如果文件夹名称包含空格，需使用双引号将路径引起来，如：cd "c:\program file\my.txt"。`cd ..` 表示进入父目录。

```
C:\Users\mudaozi>cd Documents

C:\Users\mudaozi\Documents>cd ..

C:\Users\mudaozi>cd ../..

C:\>
```

## `dir` 显示目录中的内容

|      命令      |                             功能                             |
| :------------: | :----------------------------------------------------------: |
|     `dir`      |                显示当前目录下的子文件夹与文件                |
|    `dir /b`    |           只显示当前目录中的子文件夹与文件的文件名           |
|    `dir /p`    |                           分页显示                           |
|   `dir /ad`    |                   显示当前目录中的子文件夹                   |
|   `dir /a-d`   |                     显示当前目录中的文件                     |
| `dir c:\test`  |                  显示 c:\test 目录中的内容                   |
| `dir keys.txt` |                显示当前目录中 keys.txt 的信息                |
|    `dir /S`    |                   递归显示当前目录中的内容                   |
|   `dir key*`   |        显示当前目录下以 key 开头的文件和文件夹的信息         |
| `dir /AH /OS`  | 只显示当前目录中隐藏的文件和目录，并按照文件大小从小到大排序 |

## `tree` 图示目录结构

```
卷 OS 的文件夹 PATH 列表
卷序列号为 D048-2ACC
C:.
├─code
├─doc
│      01_Introduction.md
│      02_Directory_Operation.md
│      Windows_Command_Line_and_Stata.md
│
└─img
        1-1.jpg
        1-2.png
        1-3.png
```

在自己实证研究或者与人合作时，项目说明文档如果能写清楚文件夹结构，这样整个项目内容一清二楚。那么怎么才能如上图显示文件结构呢？使用 `tree` 命令。
`tree c:\myfiles` 表示显示 `d:\myfiles` 路径下的文件夹，`tree c:\myfiles /F` 则显示每个文件夹中文件的名称。

在 Stata 中，外部命令 `ftree` 可是实现此功能，如果想要体验可以输入 `ssc install ftree`, replace` 进行安装。

## `mkdir` 创建文件夹

`mkdir` 或者 `md` 命令可以创建文件夹。

```
MKDIR [drive:]path
MD [drive:]path

如果命令扩展被启用，MKDIR 会如下改变:

如果需要，MKDIR 会在路径中创建中级目录。例如: 假设 \a 不
存在，那么:

    mkdir \a\b\c\d

与:

    mkdir \a
    chdir \a
    mkdir b
    chdir b
    mkdir c
    chdir c
    mkdir d

相同。如果扩展被停用，则需要键入 mkdir \a\b\c\d。
```

## `rmdir` 删除文件夹

`rmdir` 或者 `rd` 用于删除文件夹。默认删除路径下文件夹，如果需要删去所有子目录和文件，添加 `/s` 选项。使用 `/s` 选项时，默认会询问是否确认删除，如果添加 `/q` 选项，则为安静模式，不需要确认。

```
RMDIR [/S] [/Q] [drive:]path
RD [/S] [/Q] [drive:]path

    /S      除目录本身外，还将删除指定目录下的所有子目录和
            文件。用于删除目录树。

    /Q      安静模式，带 /S 删除目录树时不要求确认
```
