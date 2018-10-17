class point(object):
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __repr__(self):
        return f"({self.x},{self.y})"

    def __lt__(self, p2):
        if self.x <= p2.x and self.y < p2.y:
            return -1
        if self.y <= p2.y and self.x < p2.x:
            return -1
        return 1
def dist(p1:point, p2:point):
    val=(p1.x-p2.x)^2+(p1.y)^2
    return val
def orientation(p1:point,p2:point ,p3:point):
    val = (p2.y-p1.y)*(p3.x-p2.x)-(p2.x-p1.x)*(p3.y-p2.y)
    if val==0:
        return 0
    if val>0:
        return 1
    else:
        return -1

def compare(p1:point, p2:point):
    p0 = point(0,0)
    orient = orientation(p0,p1,p2)
    if orient == 0:
        if dist(p0,p2)<dist(p0,p1):
            return True
        else:
            return False
    if orient == 1:
        return True
    else:
        return False

v = [point(-1, -2), point(-1, 2), point(1, 2), point(1, -2), point(0, 0)]
v.sort()
print(v)
