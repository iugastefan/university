package main

import (
	"errors"
	"fmt"
)

type punct struct {
	x, y int
}
type segment struct {
	x, y punct
}
type equation struct {
	a, b, c int
}

func delta(d1, d2 equation) int {
	return d1.a*d2.b - d2.a*d1.b
}
func calc_equation(p1, p2 punct) equation {
	a := p1.y - p2.y
	b := p2.x - p1.x
	c := p1.x*p2.y - p1.y - p2.x
	return equation{a, b, c}
}
func verif(p punct, d equation) bool {
	if d.a*p.x+d.b*p.y+d.c == 0 {
		return true
	}
	return false
}
func probl1(d1, d2 equation) (punct, error) {
	x := (-d1.c*d2.b + d2.c*d1.b) / delta(d1, d2)
	y := (d1.a*(-d2.c) + d2.a*d1.c) / delta(d1, d2)
	p := punct{x, y}
	if verif(p, d1) && verif(p, d2) {
		return p, nil
	}
	return p, errors.New("punctul nu se verifica")
}
func dist(p1, p2 punct) int {
	return (p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2
}
func between(p punct, d segment) bool {
	return dist(d.x, p)+dist(p, d.y) == dist(d.x, d.y)
}
func probl2a(p1, p2, p3, p4 punct) (segment, error) {
	if between(p1, segment{p3, p4}) && between(p2, segment{p3, p4}) {
		return segment{p1, p2}, nil
	}
	if between(p1, segment{p3, p4}) {
		if between(p4, segment{p1, p2}) {
			return segment{p1, p4}, nil
		}
		if between(p3, segment{p1, p2}) {
			return segment{p1, p3}, nil
		}
	}
	if between(p2, segment{p3, p4}) {
		if between(p4, segment{p1, p2}) {
			return segment{p2, p4}, nil
		}
		if between(p3, segment{p1, p2}) {
			return segment{p2, p3}, nil
		}
	}
	if between(p3, segment{p1, p2}) || between(p4, segment{p1, p2}) {
		return probl2a(p3, p4, p1, p2)
	}
	return segment{}, errors.New("multimea vida")
}
func probl(p1, p2, p3, p4 punct) {
	d1 := calc_equation(p1, p2)
	d2 := calc_equation(p3, p4)

	if delta(d1, d2) != 0 {
		p, err := probl1(d1, d2)
		if err == nil {
			fmt.Println(p)
		} else {
			fmt.Println(err)
		}
	} else {
		if d1.a*d2.b-d2.a*d1.b == 0 && d1.a*d2.c-d2.a*d1.c == 0 && d1.b*d2.c-d2.b*d1.c == 0 {
			seg, err := probl2a(p1, p2, p3, p4)
			if err != nil {
				fmt.Println(seg)
			} else {
				fmt.Println(err)
			}
		}
	}
}
func main() {

}
