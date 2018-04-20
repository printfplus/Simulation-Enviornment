import json
file = open('test.json','w',encoding='utf-8')  
data1 = {'name':'john',"age":12}  
data2 = {'name':'merry',"age":13}  
data = [data1,data2]  
print(data)  
json.dump(data,file,ensure_ascii=False)  
file.close()  
file = open('test.json','r',encoding='utf-8')  
s = json.load(file)  
print (s[0]['name'])  