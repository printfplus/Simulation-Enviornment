import numpy as np
class A_Series():

	def __init__(self,a_list = np.ones(30)):
		
		self.a_list = a_list

	def set_value(step_num,value):
		self.a_list[step_num-1] = value