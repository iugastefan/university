import sys
maxim = sys.maxsize


class punct:
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z

    def __repr__(self):
        return (f"({self.x},{self.y},{self.z})")


def diferite(p1, p2, p3=None):
    if p3 is None:
        return (p1.x != p2.x or p1.y != p2.y or p1.z != p2.z)
    return (diferite(p1, p2) and diferite(p2, p3) and diferite(p1, p3))


class dreapta:
    def __init__(self, p1: punct, p2: punct):
        self.x = p2.x - p1.x
        self.y = p2.y - p1.y
        self.z = p2.z - p1.z


def raport(d1, d2):
    rx = maxim
    ry = maxim
    rz = maxim
    if d2.x != 0 and d1.x != 0:
        rx = d1.x / d2.x
        if rx * d2.y == d1.y and rx * d2.z == d1.z:
            return rx
        return maxim
    if d2.y != 0 and d1.y != 0:
        ry = d1.y / d2.y
        if ry * d2.z == d1.z:
            return ry
        return maxim
    if d2.z != 0 and d1.z != 0:
        rz = d1.z / d2.z
        return rz
    return maxim


def afis_puncte(p1: punct, p2: punct, p3: punct):
    print(f"\nA1 = {p1}\nA2 = {p2}\nA3 = {p3}")


def ex_a(p1: punct, p2: punct, p3: punct):
    d12 = dreapta(p1, p2)
    d23 = dreapta(p2, p3)
    afis_puncte(p1, p2, p3)
    if diferite(p1, p2, p3) == False:
        print("Puncte identice")
        return
    if raport(d12, d23) != maxim:
        print("Sunt coliniare")
        return
    print("Nu sunt coliniare")
    return


def ex_b(p1: punct, p2: punct, p3: punct):
    d12 = dreapta(p1, p2)
    d23 = dreapta(p2, p3)
    if diferite(p1, p2, p3) == False:
        if diferite(p1, p2) == False:
            print("A1 = 1*A2 + 0*A3")
            return
        if diferite(p2, p3) == False:
            print("A2 = 1*A3 + 0*A1")
            return
        if diferite(p1, p3) == False:
            print("A1 = 1*A3 + 0*A2")
            return
    a = raport(d12, d23)
    if a != maxim:
        print(f"A1 = {1+a}*A2 + ({-a})*A3")


def test_puncte_identice():
    p1 = punct(1, 1, 0)
    p2 = punct(1, 1, 0)
    p3 = punct(1, 1, 0)
    ex_a(p1, p2, p3)
    ex_b(p1, p2, p3)


def test_2_puncte_identice():
    p1 = punct(1, 1, 0)
    p2 = punct(1, 2, 3)
    p3 = punct(1, 1, 0)
    ex_a(p1, p2, p3)
    ex_b(p1, p2, p3)


def test_puncte_coliniare():
    p1 = punct(-2, -2, 0)
    p2 = punct(2, 2, 0)
    p3 = punct(4, 4, 0)
    ex_a(p1, p2, p3)
    ex_b(p1, p2, p3)


def test_puncte_necoliniare():
    p1 = punct(3, 3, 0)
    p2 = punct(2, 2, 5)
    p3 = punct(4, 4, 0)
    ex_a(p1, p2, p3)
    ex_b(p1, p2, p3)


test_puncte_identice()
test_2_puncte_identice()
test_puncte_coliniare()
test_puncte_necoliniare()
