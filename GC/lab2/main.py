class punct(object):
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


v = [punct(-1, -2), punct(-1, 2), punct(1, 2), punct(1, -2), punct(0, 0)]
v.sort()
print(v)
