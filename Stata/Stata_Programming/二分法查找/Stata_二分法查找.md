
Stata | 520 听说你也想快点找到...

# 前言

看见朋友圈满屏的 99999 ，才反应过来一年一度 520 到了。作为单身狗，这节日必然“雨我无瓜”。但是啥？你说你想快点找对象？那二分查找算法了解一下。

# 算法原理

二分查找算法（binary search algorithm），也称折半搜索算法（half-interval search algorithm），是一种在**有序数组**中查找某一特定元素的搜索算法。搜索过程是从数组的中间元素开始，如果中间元素正好是要查找的元素，则搜索过程结束；如果某一特定元素大于或者小于中间元素，则在数组大于或小于中间元素的那一半中查找，而且跟开始一样从中间元素开始比较如果在某一步骤数组为空，则代表找不到。**这种搜索算法每一次比较都使搜索范围缩小一半**。

![](./image/4.gif)

以上面的动图为例，要在 1~35 的 16 个元素中找到 37 ，使用二分法则只需要 3 步，而遍历查找需要 11 步。

二分查找的查找过程如下：

- 第一步：比较第 `(0+16)/2 = 8` 个元素与 37 的大小；
- 第二步：因为第 8 个元素为 23 小于 37，折半取第 8 位至 16 位的中间元素 41 和 37 比较；
- 第三步：因为 41 大于 37 ，再折半取中间元素 31 与 37 比较，31 小于 31 ，折半取 31 右侧，即 37，查找结束。

# 实现过程

知道了算法运行的原理，接下来我们用 Stata 比较几种方式的查找效率。**我们要解决的问题是：假设有 1~999999 个有序数字，从中查找 5201314 **。用代码表示：

```Stata
clear
set rmsg on //show how long the command took

set obs 9999999
gen n = _n
scalar target =  5201314
```

## 遍历查找

```
* 遍历查找
forvalues guess = 1/`=_N'{
	if `guess' == target{
		dis "找到" target "啦！"
		continue, break
	}
}

/*
Output:
找到 5201314 啦！
r; t=42.98 10:55:14
*/

```
## 二分查找

```Stata
local low = 1
local high = `=_N'

while `low' <= `high'{
	local mid = (`low' +`high') / 2
	local guess = n[`mid']

	if `guess' == target{
		dis "找到" target "啦！"
		continue, break
	}
	if `guess' > target{
		local high = `mid' - 1
	}
	else{
		local low = `mid' + 1
	}
	
}

/*
Output:
找到5201314啦！
r; t=0.00 10:55:32
*/

```

## 调用 Python

```Stata
python:
from sfi import Data
import time

def binary_search(n, target):
	low = 0
	high = len(n) - 1

	while low <= high:
		mid = int((low + high)/2)
		guess = n[mid]
		if guess == target:
			return mid
		if guess > target:
			high = mid - 1
		else:
			low = mid + 1
		return None

n = Data.get(var='n')
target = 5201314
start = time.time()
binary_search(n,target)
end = time.time()
print("耗时:{}".format(end-start))
end

/*
Output:
耗时:0.0009615421295166016
*/
```


# 小结

从运行的结果来看，遍历查找需要 42 秒左右，而二分查找的速度快多了，简直是秒杀。二分查找作为经典的算法，日常生活中还是挺实用的，比如从通讯录查找某姓氏开头朋友的电话、根据学号查找对应的姓名等，都能够派上用场。今天的推文到这里就结束了，看完后掌握了如何快速找对象的方法了吗？$\tan90^\circ$，520 还在写代码就别想了。最后，祝单身 dog 早日脱单，有情人终成眷属，完结撒花！


# 参考资料
https://zh.wikipedia.org/wiki/%E4%BA%8C%E5%88%86%E6%90%9C%E5%B0%8B%E6%BC%94%E7%AE%97%E6%B3%95
https://blog.penjee.com/binary-vs-linear-search-animated-gifs/
https://www.ituring.com.cn/book/1864