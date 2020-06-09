
cd "C:\Users\mudaozi\Documents\WeChatPlatform\Stata\Stata_Data_Managemet\提取图片内容和排序"

python:
import pytesseract
from PIL import Image

# 从图片识别文本
image = "问卷修改清单.jpg"
f = open("问卷修改内容.txt", "a")
text = str(((pytesseract.image_to_string(Image.open(image), lang='chi_sim'))))
text = text.replace(' ', '')
f.write(text)
f.close()
end


import delimited "问卷修改内容.txt", clear encoding("gb18030")
gen content = v1 + v2
drop if ustrregexm(content, "(.*)月(.*)日") == 1 | ///
ustrregexm(content, "修改|改动|注意事项") == 1
keep content
duplicates drop

replace content = usubinstr(content, "I","1",1) ///
if ustrregexm(content,"[A-Z]I|[A-Z]L\d+") == 1
gen number = ustrregexs(0) if ustrregexm(content,"[A-Z]\d+") == 1
sort content
order number content