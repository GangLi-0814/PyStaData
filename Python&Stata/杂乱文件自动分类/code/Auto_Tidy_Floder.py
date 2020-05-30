'''
实现文件夹下文件自动分类
'''

import os
import shutil

os.getcwd()
os.listdir()
os.chdir("../files")

for f in files:
    folder = f.split('.')[-1]
    if not os.path.exists(folder):
        os.mkdir(folder)
        shutil.move(f, folder)
    else:
        shutil.move(f, folder)