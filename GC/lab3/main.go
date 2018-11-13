package main

import (
	"errors"
	"fmt"
	"math"
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
func calcEquation(p1, p2 punct) equation {
	a := p1.y - p2.y
	b := p2.x - p1.x
	c := p1.x*p2.y - p1.y*p2.x
	return equation{a, b, c}
}
func between(p punct, d segment) bool {
	return Round(dist(d.x, p)+dist(p, d.y), 0.05) == Round(dist(d.x, d.y), 0.05)
}
func probl1(p1, p2, p3, p4 punct) (punct, error) {
	d1, d2 := calcEquation(p1, p2), calcEquation(p3, p4)
	x := (-d1.c*d2.b + d2.c*d1.b) / delta(d1, d2)
	y := (d1.a*(-d2.c) + d2.a*d1.c) / delta(d1, d2)
	p := punct{x, y}
	if between(p, segment{p1, p2}) && between(p, segment{p3, p4}) {
		return p, nil
	}
	return p, errors.New("punctul nu se verifica")
}
func dist(p1, p2 punct) float64 {
	return math.Sqrt(math.Pow(float64(p1.x-p2.x), 2) + math.Pow(float64(p1.y-p2.y), 2))
}
func Round(x, unit float64) float64 {
	return math.Round(x/unit) * unit
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
func rangMatrExt(d1, d2 equation) (int) {
	if d1.a*d2.b-d2.a*d1.b == 0 && d1.a*d2.c-d2.a*d1.c == 0 && d1.b*d2.c-d2.b*d1.c == 0 {
		return 1
	}
	return 2
}
func probl(p1, p2, p3, p4 punct) {
	d1 := calcEquation(p1, p2)
	d2 := calcEquation(p3, p4)

	if delta(d1, d2) != 0 {
		p, err := probl1(p1, p2, p3, p4)
		if err != nil {
			fmt.Println(err)
		} else {
			fmt.Println(p)
		}
	} else {
		if rangMatrExt(d1, d2) == 1 {
			seg, err := probl2a(p1, p2, p3, p4)
			if err != nil {
				fmt.Println(err)
			} else {
				fmt.Println(seg)
			}
		} else {
			fmt.Println("segmentele nu se intersecteaza")
		}
	}
}
func main() {
	probl(punct{-1, -1}, punct{1, 1}, punct{1, -1}, punct{3, 1})
}