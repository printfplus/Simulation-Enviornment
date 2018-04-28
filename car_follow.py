import numpy 
import scipy.stats as st 
import scipy
import pandas as pd


def pid_follow(x1,v1,x2,v2,k1 = 1.12,k2 = 1.70,amax = 3,amin = -3):
	headway = 1.4
	#range_error = x1-x2-headway*v2]
	range_error = x1-x2-50
	range_rate_error = v1-v2
	a = k1*range_error+k2*range_rate_error

	return a

def car_follow(x1,v1,x2,v2,amax = 3,amin = -3):
	PAR = 500
	objective_a = (PAR*(v2)**0.6)*(v2-v1)/((abs(x2-x1))**2.4*numpy.sign(x2-x1))
	if objective_a > amax:
		objective_a = amax
	elif objective_a < amin:
		objective_a = amin
	return objective_a

def ttc(x1,v1,x2,v2):
	if x1>x2:
		ttc = -(v2-v1)/(x1-x2)
		if ttc <-1000:
			ttc = -1000
	else:
		ttc = -2000

	return ttc


def reward_and_done(x1,v1,x2,v2,stepnum):
	if abs(x1-x2) < 2 or x1 < x2:
		reward = 1000
		done = 1
	else:
		#reward = ttc(x1,v1,x2,v2)
		reward = -1
		done = 0
	return reward,done

def update(x,v,a,vmax = 40,vmin = 0,dt = 1):
	if v == vmax and a > 0:
		a = 0
	elif v == vmin and a < 0:
		a = 0
	x = x+v*dt+0.5*a*dt*dt
	v = v+a*dt
	if v > vmax:
		v = vmax
	elif v < vmin:
		v = vmin
	return x,v


def random_effect(a,random_type = 'normal',random_parameter = [0,0.55]):

	if random_type == 'normal':
		return numpy.round(numpy.random.normal(random_parameter[0],random_parameter[1],1),2)[0]

def pid_follow_with_random(x1,v1,x2,v2,k1 = 1.12,k2 = 1.70,amax = 3,amin = -3,newparameter = [],random = 'on'):
	a = pid_follow(x1,v1,x2,v2,k1 = k1,k2 = k1,amax = amax,amin = amin)
	if random == 'on':
		theta = 0
		a = random_effect(a,random_type='normal',random_parameter=[a,theta])
		
	if a > amax:
		a = amax
	elif a < amin:
		a = amin

	return a


def get_series(lb,ub,step):
	series = [lb+i*((ub-lb)/step) for i in range(step+1)]
	return series

def get_possilbility(x,mu,lb,ub,split_whole,split_num):
	
	split_value = lb+(ub-lb)*split_num/split_whole
	split_value_plus = lb+(ub-lb)*(split_num+1)/split_whole
	#print(split_value)
	#print(split_value_plus)
	whole_possibility = st.norm(x,mu).cdf(ub)-st.norm(x,mu).cdf(lb)
	one_possibility = scipy.stats.norm(x,mu).cdf(split_value_plus)-scipy.stats.norm(x,mu).cdf(split_value)
	return one_possibility/whole_possibility


class x_distribution():

	def __init__(self,range_x,range_mu,range_lb,range_ub,range_rate_x,range_rate_mu,range_rate_lb,range_rate_ub):
		self.range_split = 10
		self.range_rate_split = 10
		self.range_x = range_x
		self.range_mu = range_mu
		self.range_lb = range_lb
		self.range_ub = range_ub
		self.range_rate_x = range_rate_x
		self.range_rate_mu = range_rate_mu
		self.range_rate_lb = range_rate_lb
		self.range_rate_ub = range_rate_ub
		self.range_list = []
		self.range_rate_list = []
		self.generate_two_list()
		self.get_possibility_table()

	def generate_two_list(self):
		for rx in range(self.range_split):
			range_split_value = self.range_lb+(self.range_ub-self.range_lb)*rx/self.range_split
			self.range_list.append((range_split_value,get_possilbility(self.range_x,self.range_mu,self.range_lb,self.range_ub,self.range_split,rx)))
		for rrx in range(self.range_rate_split):
			range_rate_split_value = self.range_rate_lb+(self.range_rate_ub-self.range_rate_lb)*rrx/self.range_split
			self.range_rate_list.append((range_rate_split_value,get_possilbility(self.range_rate_x,self.range_rate_mu,self.range_rate_lb,self.range_rate_ub,self.range_rate_split,rrx)))

	def get_possibility_table(self):
		index = [self.range_list[i][0] for i in range(self.range_split)]
		column = [self.range_rate_list[i][0] for i in range(self.range_rate_split)]
		self.possibility_table = pd.DataFrame(index = index,columns = column)

		for rx in range(self.range_split):
			for rrx in range(self.range_rate_split):
				self.possibility_table.at[self.range_list[rx][0],self.range_rate_list[rrx][0]] = self.range_list[rx][1]*self.range_rate_list[rrx][1]
		print(self.possibility_table)
		self.possibility_table.to_csv('possibility_table.csv')





A = x_distribution(60,20,0,100,-10,5,-20,20)

