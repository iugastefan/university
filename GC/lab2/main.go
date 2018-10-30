package main

import (
	"fmt"
	"sort"
)

type point struct {
	x int
	y int
}

func ccw(p1, p2, p3 point) bool {
	return ((p2.x-p1.x)*(p3.y-p1.y) - (p2.y-p1.y)*(p3.x-p1.x)) < 0
}

type points []point

func (p points) Len() int {
	return len(p)
}
func (p points) Swap(i, j int) {
	p[i], p[j] = p[j], p[i]
}
func (p points) Less(i, j int) bool {
	return ((p[0].y - p[i].y) * (p[0].x - p[j].x)) < ((p[0].y - p[j].y) * (p[0].x - p[i].x))
}
func (p *points) min() {
	pmin := point{999, 999}
	min := 0
	for j, i := range *p {
		if i.y < pmin.y {
			min = j
		} else {
			if i.y == pmin.y {
				if i.x < pmin.x {
					min = j
				}
			}
		}
	}
	(*p)[0], (*p)[min] = (*p)[min], (*p)[0]
}
func main() {
	puncte := points{{-8, 0}, {-6, -2}, {-4, 0}, {-4, -2}, {-3, 2}, {-2, 2}, {0, -1},
		{2, -4}, {4, -2}, {6, 2}, {8, 8}, {10, 0}}
	puncte.min()
	sort.Sort(points(puncte))
	fmt.Println(puncte)
	stack := make(points, 0)
	stack = append(stack, puncte[0])
	stack = append(stack, puncte[1])
	stack = append(stack, puncte[2])
	for i := 3; i < len(puncte); i++ {
		for ccw(stack[len(stack)-2], stack[len(stack)-1], puncte[i]) {
			stack = stack[:len(stack)-1]
		}
		stack = append(stack, puncte[i])
	}
	fmt.Println(stack)
}
