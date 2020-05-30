python:
import nltk   
import requests
from bs4 import BeautifulSoup


url = "https://www.stata.com/new-in-stata/python-integration/"    
html = requests.get(url)  
text = BeautifulSoup(html.text).get_text() 
print(text)

from wordcloud import WordCloud

wordcloud = WordCloud(max_font_size=75, max_words=100, background_color="white").generate(text)

from sfi import Platform
import matplotlib
if Platform.isWindows():
    matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.savefig("words.png")
end