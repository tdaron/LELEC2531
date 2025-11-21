class Montgomery:
    BASE = 2

    def __init__(self, m):
        self.m = m
        self.n = m.bit_length()
        self.r = (1 << self.n)
        self.rrm = (self.r * self.r) % m

    def reduce(self, t):
        a = t
        counter = self.r >> 1;
        while(counter != 0):
            print(a)
            if (a & 1) == 1:
                a += self.m
            a >>= 1
            counter >>= 1
            
        print("\n")
        
        if a >= self.m:
            a -= self.m
        return a

if __name__ == "__main__":
    m = 293
    x1 = 234
    x2 = 167

    mont = Montgomery(m)
    
    t1 = x1 * mont.rrm
    t2 = x2 * mont.rrm
    r1 = mont.reduce(t1)
    r2 = mont.reduce(t2)
    
    print(f"r = {mont.r}, r^2 % m = {mont.rrm}")
    print(f"(x1 * x2) % m = ({x1} * {x2}) % {m}")
    print("Montgomerry : x1 = {r1}, x2 = {r2}")

    mult = mont.reduce(mont.reduce(r1 * r2))
    print("Montgomerry : x1 * x2 = " + str(mult))
    print("Normal : x1 * x2 = " + str((x1 * x2) % m))

