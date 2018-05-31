from Initial import *
from A_Series import A_Series
import json
from car_follow import *
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time

Test_Step = 100

class SimuEnv():
	"""docstring for SimuEnv"""
	def __init__(self, initial):
		print("envstart")
		self.initial = initial
		self.a_back_series = [0 for x in range(self.get_step())]
		self.car_follow_type = 0
		self.collision_flag = 0
		self.collision_rate = 0

	def setting(self,follow_type):
		self.car_follow_type = follow_type


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
		self.collision_flag = 0
		self.collision_rate = 0



	def simulate(self,random = 'off',display = 'off',savefig = 'off'):
		step = self.get_step()
		x1,v1,x2,v2 = self.initial.get_state()
		if savefig == 'on':
				x1_list = [x1]
				v1_list = [v1]
				x2_list = [x2]
				v2_list = [v2]

		for i in range(step):

			self.a_back_series[i] = pid_follow_with_random(x1,v1,x2,v2,random = random)

			x1,v1 = update(x1,v1,self.get_a1(i),dt = self.initial.dt)
			x2,v2 = update(x2,v2,self.a_back_series[i],dt = self.initial.dt)
			if x1 - x2 < 2:
				self.collision_flag = 1

			if display == 'on':
				print(x1,v1,x2,v2)

			if savefig == 'on':
				x1_list.append(x1)
				v1_list.append(v1)
				x2_list.append(x2)
				v2_list.append(v2)
		if savefig == 'on':
			#print(x1_list)
			print(x2_list)
			#print(self.a_back_series)
			#print(v2_list)
			#print(v1_list)
			plt.plot(x1_list)
			plt.plot(x2_list)
			plt.plot(v2_list)





	def start(self,rlb,rub,rstep,rrlb,rrub,rrstep,random = 'off'):
		print("starting simulation")
		tic = time.time()

		range_error_series = get_series(rlb,rub,rstep)
		#print(range_error_series)
		range_rate_error_series = get_series(rrlb,rrub,rrstep)
		#print(range_rate_error_series)
		whole_serie = []
		for RE in range(len(range_error_series)):
			#print(RE)
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
						self.simulate(random = random)
						collision_times = collision_times+self.collision_flag
					self.collision_rate = collision_times/Test_Step
					RRE_serie.append(self.collision_rate)		
			whole_serie.append(RRE_serie)

		df = pd.DataFrame(whole_serie,index=list(map(str,range_error_series)),columns=list(map(str,range_rate_error_series)))
		
		toc = time.time()

		return df,toc-tic












I = Initial(step = 10,dt = 1)
env = SimuEnv(initial = I)
env.setting(1)
print("hello")

whole_serie,whole_time = env.start(rlb = 0,rub = 98,rstep = 49,rrlb = -20,rrub = -4,rrstep = 40,random = 'off')
whole_serie.to_csv('NDD_new.csv')
print("using "+str(whole_time)+" seconds")

env.set_state(100,-17)
env.simulate(display = 'off',savefig = 'on')
#plt.plot(env.a_back_series)
#plt.legend(labels = ['x1', 'x2','v2','a1'], loc = 'best')
#plt.show()
