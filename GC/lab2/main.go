package main

import (
	"fmt"
	"sort"
)

type point struct {
	x, y int
}

func ccw(p1, p2, p3 point) bool {
	return (p3.y-p1.y)*(p2.x-p1.x) < (p2.y-p1.y)*(p3.x-p1.x)
}

type points []point

func (p points) Len() int {
	return len(p)
}
func (p points) Swap(i, j int) {
	p[i], p[j] = p[j], p[i]
}
func (p points) Less(i, j int) bool {
	return ccw(p[0], p[j], p[i])
}
func (p *points) min() {
	pmin := point{999, 999}
	min := 0
	for j, i := range *p {
		if i.y < pmin.y {
			min = j
			pmin = i
		} else {
			if i.y == pmin.y {
				if i.x < pmin.x {
					min = j
					pmin = i
				}
			}
		}
	}
	(*p)[0], (*p)[min] = (*p)[min], (*p)[0]
}
func graham(puncte points) (points, points) {
	puncte.min()
	sort.Sort(points(puncte))
	stack := make(points, 0)
	stack2 := make(points, 0)
	stack = append(stack, puncte[0])
	stack = append(stack, puncte[1])
	stack = append(stack, puncte[2])
	for i := 3; i < len(puncte); i++ {
		for ccw(stack[len(stack)-2], stack[len(stack)-1], puncte[i]) {
			stack2 = append(stack2, stack[len(stack)-1])
			stack = stack[:len(stack)-1]
		}
		stack = append(stack, puncte[i])
	}
	return stack, stack2
}
func problema(puncte points) {
	stack, stack2 := graham(puncte)
	if len(stack) == 4 {
		fmt.Println(stack)
		fmt.Printf("I: %v, %v\n", stack[0], stack[2])
		fmt.Printf("J: %v, %v\n", stack[1], stack[3])
	} else if len(stack) == 3 {
		fmt.Printf("I: %v\n", stack)
		fmt.Printf("J: %v\n", stack2)
	}
}
func main() {

	fmt.Println("Patrulater")
	patrulater := points{{0, 0}, {3, 1}, {2, 3}, {1, 2}}
	problema(patrulater)

	fmt.Println("Triunghi")
	triunghi := points{{0, 0}, {1, 1}, {1, 3}, {3, 0}}
	problema(triunghi)

	fmt.Println("Coliniare")
	coliniare := points{{4, 0}, {1, 0}, {2, 0}, {3, 0}}
	problema(coliniare)

}
