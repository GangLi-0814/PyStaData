
import requests
import random
import json
from hashlib import md5

def make_md5(s, encoding='utf-8'):
    '''
    生成随机数和签名
    '''
    return md5(s.encode(encoding)).hexdigest()

def translate(query, from_lang, to_lang):
    '''
    调用百度翻译 API
    '''
    url = 'http://api.fanyi.baidu.com/api/trans/vip/translate'
    salt = random.randint(1, 65536) #随机数
    sign = make_md5(appid + query + str(salt) + appkey)

    # 构造请求
    headers = {'Content-Type': 'application/x-www-form-urlencoded'}
    payload = {'appid': appid, 
               'q': query, 
               'from': from_lang, 
               'to': to_lang, 
               'salt': salt, 
               'sign': sign
              }
    r = requests.post(url, params=payload, headers=headers)
    text = r.json()
    result = text['trans_result'][0]['dst']
    return result


def transAssistant(query):
    '''
    中-英-日-中
    '''
    en = translate(query,'zh','en') #中文-英文
    jp = translate(en,'en','jp') #英文-日文
    zh = translate(jp,'jp','zh') #日文-中文
    return zh

appid = ""
appkey = ""
query = '这是我要降低重复率的问题，给我把重复率降低到达到要求，祝大家论文过过过。'
# print(translate(query,"zh","en"))
print(transAssistant(query))