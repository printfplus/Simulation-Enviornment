from Initial import Initial
from A_Series import A_Series
import json
from car_follow import *
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time

car_follow_Dic = {
    0: "None",
    1: "PID_follow",
    2: "LEFT",
    3: "RIGHT"
}

Test_Step = 100

class SimuEnv():
	"""docstring for SimuEnv"""
	def __init__(self, initial):
		self.initial = initial
		self.a_back_series = [0 for x in range(self.get_step())]
		self.car_follow_type = 0
		self.collision_flag = 'unknown'
		self.collision_rate = 'unknown'

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
	
	def get_a1(self,number):
		return self.initial.get_a(number)

	def get_a2(self,number):
		return self.a_back_series[number]

	def set_state(self,range_error,range_rate_error):
		self.initial.set_state(range_error,range_rate_error)


	def simulate(self,random = 'off'):
		step = self.get_step()
		x1,v1,x2,v2 = self.initial.get_state()
		for i in range(step):
			if random == 'off':
				self.a_back_series[i] = pid_follow(x1,v1,x2,v2)
			else:
				self.a_back_series[i] = pid_follow_with_random(x1,v1,x2,v2)
			x1,v1 = update(x1,v1,self.get_a1(i))
			x2,v2 = update(x2,v2,self.a_back_series[i])
			if x1 - x2 < 2:
				self.collision_flag = 1
			else:
				self.collision_flag = 0




	def start(self,rlb,rub,rstep,rrlb,rrub,rrstep,random = 'off'):
		print("starting simulation")
		tic = time.time()

		range_error_series = get_series(rlb,rub,rstep)
		#print(range_error_series)
		range_rate_error_series = get_series(rrlb,rrub,rrstep)
		#print(range_rate_error_series)
		whole_serie = []
		for RE in range(len(range_error_series)):
			print(RE)
			RRE_serie = []
			for RRE in range(len(range_rate_error_series)):
				if random == 'off':
					self.set_state(range_error_series[RE],range_rate_error_series[RRE])
					self.simulate()
					RRE_serie.append(int(self.collision_flag))
				else:
					collision_times = 0
					for i in range(Test_Step):
						self.set_state(range_error_series[RE],range_rate_error_series[RRE])
						self.simulate(random)
						collision_times = collision_times+self.collision_flag
					self.collision_rate = collision_times/Test_Step
					RRE_serie.append(self.collision_rate)		
			whole_serie.append(RRE_serie)

		df = pd.DataFrame(whole_serie,index=range_error_series,columns=range_rate_error_series)
		
		toc = time.time()

		return df,toc-tic

	def plot(self):
		plt.plot()













I = Initial()
env = SimuEnv(initial = I)
env.setting(1)
whole_serie,whole_time = env.start(rlb = 0,rub = 100,rstep = 50,rrlb = -20,rrub = 20,rrstep = 40,random = 'on')
whole_serie.to_csv('new.csv')
#print(whole_serie)
print("using "+str(whole_time)+" seconds")

