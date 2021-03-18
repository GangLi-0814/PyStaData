cd "cd /Users/gangli/PyStaData/PhD/MicroEcon/平狄克-微观经济学/code/data"

ssc install graph3d,replace

* 





* 短期成本曲线
use "07_1_厂商的成本.dta", clear 

* 计算 MC，AFC，AVC，ATC

* 绘图
grss line tc vc fc outputrate 
grss line mc atc avc afc outputrate
grss clear

