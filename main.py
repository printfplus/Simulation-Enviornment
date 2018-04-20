from Initial import Initial
from SimuEnv import SimuEnv
from A_Series import A_Series

if __name__ == '__main__':
	main()

def main():
	initial = Initial()
	env = SimuEnv(initial)
	env.setting()
	env.start()
