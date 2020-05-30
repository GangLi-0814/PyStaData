
clear
set rmsg on
set obs 9999999

gen n = _n
scalar target =  5201314


* 遍历查找
forvalues guess = 1/`=_N'{
	if `guess' == target{
		dis "找到 " target " 啦！"
		continue, break
	}
}


* 二分法查找

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


* 调用 Python
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


#n = [i for i in range(10000000)]
n = Data.get(var='n')
target = 5201314
start = time.time()
binary_search(n,target)
end = time.time()
print("耗时:{}".format(end-start))
end