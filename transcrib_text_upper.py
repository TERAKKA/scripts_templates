import json
import re

json_string = """{
  "orderID": 42,
  "customerName": "John Smith",
  "customerPhoneN": "555-1234",
  "rows": [
    [
      " спрон!",
      "productName123",
      0
    ],
    [
      "гропва;",
      "productName213",
      1
    ]
  ],
  "orderContents": [
    [
      " матр № ",
      "productName1",
      0
    ],
    [
      " впром@!",
      "productName2",
      1
    ]
  ]
}"""

parsed_string = json.loads(json_string)

class rus_translit_latin(object):
    rusto = {
        u'\u0401': u'YO',
        u'\u0410': u'A',
        u'\u0411': u'B',
        u'\u0412': u'V',
        u'\u0413': u'G',
        u'\u0414': u'D',
        u'\u0415': u'E',
        u'\u0416': u'ZH',
        u'\u0417': u'Z',
        u'\u0418': u'I',
        u'\u0419': u'I',
        u'\u041a': u'K',
        u'\u041b': u'L',
        u'\u041c': u'M',
        u'\u041d': u'N',
        u'\u041e': u'O',
        u'\u041f': u'P',
        u'\u0420': u'R',
        u'\u0421': u'S',
        u'\u0422': u'T',
        u'\u0423': u'U',
        u'\u0424': u'F',
        u'\u0425': u'H',
        u'\u0426': u'TS',
        u'\u0427': u'CH',
        u'\u0428': u'SH',
        u'\u0429': u'SCH',
        u'\u042a': u"'",
        u'\u042b': u'I',
        u'\u042c': u"",
        u'\u042d': u'E',
        u'\u042e': u'YU',
        u'\u042f': u'YA',
        u'\u0430': u'a',
        u'\u0431': u'b',
        u'\u0432': u'v',
        u'\u0433': u'g',
        u'\u0434': u'd',
        u'\u0435': u'e',
        u'\u0436': u'zh',
        u'\u0437': u'z',
        u'\u0438': u'i',
        u'\u0439': u'i',
        u'\u043a': u'k',
        u'\u043b': u'l',
        u'\u043c': u'm',
        u'\u043d': u'n',
        u'\u043e': u'o',
        u'\u043f': u'p',
        u'\u0440': u'r',
        u'\u0441': u's',
        u'\u0442': u't',
        u'\u0443': u'u',
        u'\u0444': u'f',
        u'\u0445': u'h',
        u'\u0446': u'ts',
        u'\u0447': u'ch',
        u'\u0448': u'sh',
        u'\u0449': u'sch',
        u'\u044a': u"",
        u'\u044b': u'i',
        u'\u044c': u"",
        u'\u044d': u'e',
        u'\u044e': u'yu',
        u'\u044f': u'ya',
        u'\u0451': u'yo',
    }
    def __init__(self,txt):
        self.txt = txt
        
    def from_rusto(self,char):
        if char in self.rusto:
            return self.rusto[char]
        else:
            return char
    
    def transliterate(self):
        return ''.join([self.from_rusto(val) for val in self.txt])

if __name__=="__main__":

  for index, value in enumerate(parsed_string["rows"]):
    global s
    del value[1]
    s = " ".join(str(x) for x in value)
    lat = rus_translit_latin(s)
    lat = lat.transliterate()
    lat = lat.upper()
    lat = lat.strip()
    #print(lat)
    for k in lat.split("\n"):
      print(re.sub(r"[^a-zA-Z0-9_а-щыэ-яА-ЩЫЭ-Я]+", ' ', k))