
import json

class Initial():

	def __init__(self,step = 30,dt = 1):
		self.x_prev = 0
		self.v_prev = 0
		self.x_back = 0
		self.v_back = 0
		self.step = step
		self.dt = dt
		self.a_prev_series = [1 for x in range(1,step)]

	def info2list(self):
		data = [self.x_prev,self.v_prev,self.x_back,self.v_back,self.step,self.dt,self.a_prev_series]
		return data

	def list2info(self,s_list):
		[self.x_prev,self.v_prev,self.x_back,self.v_back,self.step,self.dt,self.a_prev_series] = s_list


	def save(self,id_number):
		file = open('Initial_'+str(id_number)+'.json','w',encoding='utf-8')  
		data = self.info2list()
		json.dump(data,file,ensure_ascii=False)  
		file.close()  

	def load(self,id_number):
		file = open('Initial_'+str(id_number)+'.json','r',encoding='utf-8')  
		s = json.load(file)  
		self.list2info(s)
		#print(self.a_prev_series)



I = Initial()
I.save(63)
I.load(63)