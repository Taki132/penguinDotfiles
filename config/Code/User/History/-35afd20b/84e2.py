import json
with open ("output.json","r") as dict: 
   data = json.load(dict)
tukhoa = input("nhập từ khóa tiếng anh cần tìm kiếm: ")
if tukhoa in  (data['entries']):
   a = tukhoa['part']
   if pronunciation in (tukhoa[]):
      print(tukhoa['pronunciation'])
      print(a)