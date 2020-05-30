
# 方式一
forvalues i = 0(5)100{
	dis "程序已运行 `i' %"
	if `i' == 50{
		beep
		dis in y "提醒一下"
	}
	sleep 300
}

# 方式二
!Beep.exe 240 10 /s 50 280 10 /s 50 340 10



# 方式三

python:
import winsound 

freq = 100
dur = 50
# loop iterates 5 times i.e, 5 beeps will be produced. 
for i in range(0, 10):     
    winsound.Beep(freq, dur)     
    freq += 100
    dur += 80
end




















