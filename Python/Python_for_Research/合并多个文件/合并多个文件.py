import os

os.chdir("../PyStaData/PhD/MicroEcon/Varian")
files = os.listdir()


contents = []
for md in files:
	if ".md" in md:
		with open(md, 'r') as f:
			contents.append(f.read() + "\n")

with open("result.md", "w") as f:
    f.writelines(contents)


# 获取路径、文件名和拓展名
import os

url = "http://file.iqilu.com/custom/new/v2016/images/logo.png"

(file, ext) = os.path.splitext(url)
print(file)
print(ext)

(path, filename) = os.path.split(url)
print(filename)
print(path)