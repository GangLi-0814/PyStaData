
clear
input str10 String Number
"1" 1
"2" 2
"3" 3
"4" 4
end

describe

* 导致问题
** 1.条件筛选
drop if String == "1" //文本型
drop if Number == 1  //数值型

** 2.运算
gen Add = String + Number
/*
type mismatch
r(109);
*/

gen Number_2 = Number 
gen Add = Number + Number_2 //数值运算

gen String_2 = String
gen Add_Str = String + String_2 // 字符拼接

drop Add* *_2

* 转换
destring String, gen(Str2Num)
tostring Number, gen(Num2Str)

* 分组
encode String, gen(StrEncode)
decode StrEncode, gen(NumDecode)
recode Number (1 2 = 1 low) (3 = 2 medium) (4 = 3 high), gen(NumRecode)
gen group = autocode(Number,3,1,4)

