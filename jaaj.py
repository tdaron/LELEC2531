
def reduce(T, Rminus1, n, ninv, nbits):
    m = ((T & Rminus1) * ninv) & Rminus1
    x = (T + m*n) >> nbits
    if(x < n):
        return x
    return x - n

a = 167
b = 234
n = 293

R = 1
buffer_n = n;
n_bits = 0

while(buffer_n > 0):
    buffer_n = buffer_n >> 1
    R = R << 1
    n_bits += 1

R_inv = 0
for i in range(1, n):
    if((R * i) % n == 1):
        R_inv = i

if(R_inv == 0):
    print("Bruh")
    exit()

n_inv = (R*R_inv -1)//n
Rsqr = R*R % n

t1 = reduce(Rsqr*a,R-1,n,n_inv,n_bits)
t2 = reduce(Rsqr*b,R-1,n,n_inv,n_bits)
c  = reduce(t1*t2, R-1,n,n_inv,n_bits)
z  = reduce(c, R-1,n,n_inv,n_bits)
print(z)


