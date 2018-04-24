import numpy 

def pid_follow(x1,v1,x2,v2,k1 = 1.12,k2 = 1.70,amax = 3,amin = -3):
	headway = 1.4
	range_error = x1-x2-headway*v2
	range_rate_error = v1-v2
	a = k1*range_error+k2*range_rate_error

	return a

def car_follow(x1,v1,x2,v2,amax = 3,amin = -3):
	PAR = 500
	objective_a = (PAR*(v2)**0.6)*(v2-v1)/((abs(x2-x1))**2.4*np.sign(x2-x1))
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

def update(x,v,a,vmax = numpy.inf,vmin = 0,dt = 1):
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

def pid_follow_with_random(x1,v1,x2,v2,k1 = 1.12,k2 = 1.70,amax = 3,amin = -3,newparameter = []):
	a = pid_follow(x1,v1,x2,v2,k1 = k1,k2 = k1,amax = amax,amin = amin)
	theta = 0.55
	a = random_effect(a,random_type='normal',random_parameter=[a,theta])

	if a > amax:
		a = amax
	elif a < amin:
		a = amin

	return a


def get_series(lb,ub,step):
	series = [lb+i*((ub-lb)/step) for i in range(step+1)]
	return series


