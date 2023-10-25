import json
with open ("output.json","r") as dict: 
   data = json.load(dict)
tukhoa = input("nhập từ khóa tiếng anh cần tìm kiếm: ")
x = data['entries']
if tukhoa in  (data['entries']):
   a = tukhoa['part']
   b = x [tukhoa]
   c = a['_']
   if pronunciation in (tukhoa[]):
      print(tukhoa['pronunciation'])
   print(b['meaning'])
   print(b)