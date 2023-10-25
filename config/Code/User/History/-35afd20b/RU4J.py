import json
with open ("output.json","r") as dict: 
   data = json.load(dict)
tukhoa = input("nhập từ khóa tiếng anh cần tìm kiếm: ")
a = data['entries']

print(b)
if tukhoa in a:
   if pronunciation in a:
      print(tukhoa['pronunciation'])
