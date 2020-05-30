
cd "C:\Users\mudaozi\Documents\WeChatPlatform\Others\Chrome快捷键\data"

import excel using "ManicTimeStatistics_2020-04-27.xlsx",firstrow ///
sheet("Sheet3") clear

global software "AdobeAcrobat GoogleChrome MicrosoftExcel MicrosoftPowerPoint MicrosoftWord Notepad PotPlayer SublimeText TIM Typora WeChat Windows命令处理程序 Windows资源管理器 网易云音乐"

line Stata Date, scheme(qlean)  ///
legend(pos(6) ring(6) row(5)) ///
title("个人电脑常用软件使用时长") ///
subtitle("（时间：202年1月-至今）")  ///
ytitle("使用时长（单位:小时）") ///
xtitle("月份")
 
foreach s in $software{
	addplot: line `s' Date
}

graph export "../image/Statistics_Result.png", replace width(800) height(600)