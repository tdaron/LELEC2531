import numpy as np
import time

def reduce(t, modulant, R_div_two, DATA_WIDTH):

	start_1 = time.time()

	a = [0 for i in range(0, DATA_WIDTH+1)]
	b = [0 for i in range(0, DATA_WIDTH)]
	a[0] = t
	counter = [0 for i in range(0, DATA_WIDTH+1)]
	counter[0] = R_div_two
	cond = [0 for i in range(0, DATA_WIDTH)]
	
	end_1 = time.time()
	start_2 = end_1
	
	for i in range (0,DATA_WIDTH) :
		cond[i] = counter[i] != 0
		b[i] = a[i] + modulant if ((a[i] & 1) & cond[i]) else a[i]
		a[i+1] = b[i] >> 1 if cond[i] else b[i]
		counter[i+1] = counter[i] >> 1
		
	out = a[DATA_WIDTH] - modulant if a[DATA_WIDTH] >= modulant else a[DATA_WIDTH]
	
	end_2 = time.time()
	
	print(end_1 - start_1)
	print(end_2 - start_2)
	
	return out



m = 18
x1 = 234
x2 = 167

n = m.bit_length()
r = 1 << n
DATA_WIDTH = 8
rrm = (r * r) % m

print(r)
print(rrm)

print(x1 * rrm)
a = reduce(int(x1 * rrm), m, r >> 1, DATA_WIDTH)

print(a)
