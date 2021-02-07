
import requests
from bs4 import BeautifulSoup
import time
import csv

url = "https://wh.fang.lianjia.com/loupan/pg1/"

headers = {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_2_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.146 Safari/537.36"}

response = requests.get(url=url, headers = headers)
html = response.text
soup = BeautifulSoup(html, "html.parser")