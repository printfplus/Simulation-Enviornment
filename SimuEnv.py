from Initial import Initial
from A_Series import A_Series
import json

car_follow_Dic = {
    0: "None",
    1: "PID_follow",
    2: "LEFT",
    3: "RIGHT"
}

class SimuEnv():
	"""docstring for SimuEnv"""
	def __init__(self, initial):
		self.initial = initial
		self.a_back_series = [1 for x in range(1,self.get_step())]
		self.car_follow_type = 0

	def setting(self,follow_type):
		self.car_follow_type = follow_type

	def start(self):
		if self.car_follow_type == None:
			warn_input = input("Car follow type:")

	def get_step(self):
		return self.initial.step

	def get_dt(self):
		return self.initial.dt

	def save(self,id_number):
		file = open('Simulation_'+str(id_number)+'.json','w',encoding='utf-8')  
		data = [self.initial.info2list(),self.car_follow_type,self.a_back_series]
		json.dump(data,file,ensure_ascii=False)  
		file.close()  

	def load(self,id_number):
		file = open('Simulation_'+str(id_number)+'.json','r',encoding='utf-8')  
		s = json.load(file)  
		[my_list,self.car_follow_type,self.a_back_series] = s
		self.initial.list2info(my_list)
		print(self.car_follow_type)
		

I = Initial()
env = SimuEnv(initial = I)
env.save(63)
env.load(63)