在数据整理过程中，有时会生成一些临时的文件，数据整理完之后往往需要将其删除。本文就介绍下如何用 Stata 删除路径下的所有文件。

# 实现过程

## 生成演示文件

演示需要，先生成 `temp_file` 文件夹，其中存放待删除的文件。

```Stata
* Create Directories
cap mkdir "temp_file"
cap mkdir "temp_file\dta"
cd "temp_file"

* Write Files
forvalues i = 1/10{
	!echo test -> "dta\test`i'.dta"
	!echo test -> test`i'.txt
}

* Generate File Tree
ftree,s(..\tempFileTree) d(tree)
```

运行上段代码，得到 `tempfile` 文件夹，目录结构如下：

```
卷 OS 的文件夹 PATH 列表
卷序列号为 D048-2ACC
C:.
│  test1.txt
│  test10.txt
│  test2.txt
│  test3.txt
│  test4.txt
│  test5.txt
│  test6.txt
│  test7.txt
│  test8.txt
│  test9.txt
│
└─dta
        test1.dta
        test10.dta
        test2.dta
        test3.dta
        test4.dta
        test5.dta
        test6.dta
        test7.dta
        test8.dta
        test9.dta
```

## 方式一：构造循环

使用 Stata 拓展宏获取路径下所有文件的名称，之后构造循环逐个删除。或者使用外部命令 `fs` 获取文件名，在其返回值 `r(files)` 上构造循环。两种实现方式的思路一致，都是将待删除的文件存为 `local` 后构造循环。但是这种方式只能删除文件，如果文件夹中包含子文件夹，就需要在子文件夹中再执行一次删除，当然也可以通过在外层嵌套一层循环实现。整体写法如下：

```Stata
*  Extended Function
cd "temp_file"
local files : dir . files "*.txt"
foreach f of local files {
    erase "`f'"
}

* -fs-
cd "dta"
*ssc install fs , replace
fs
foreach f in `r(files)'{
	erase `f'
}
```

## 方式二：调用 shell 命令

```Shell
!rmdir /s /q "..\temp_file"
```

`rmdir` 的基本语法如下：

```
$ help rmdir
删除一个目录。

RMDIR [/S] [/Q] [drive:]path
RD [/S] [/Q] [drive:]path

    /S      除目录本身外，还将删除指定目录下的所有子目录和
            文件。用于删除目录树。

    /Q      安静模式，带 /S 删除目录树时不要求确认
```

所以，上段代码中 `/s` 选项表示删除所有子文件夹和其中的文件，`/q` 选项安静模式，即删除的时候不询问是否确认删除。
