package main

import (
	"fmt"
	"math"
)

type punct struct {
	x, y float64
}
type vector struct {
	x, y float64
}

func calcVector(p1, p2 punct) vector {
	return vector{p1.x - p2.x, p1.y - p2.y}
}
func Round(x, unit float64) float64 {
	return math.Round(x/unit) * unit
}
func dot(v1, v2 vector) float64 {
	return float64(v1.x*v2.x + v1.y*v2.y)
}
func norm(v vector) float64 {
	return math.Sqrt(math.Pow(v.x, 2) + math.Pow(v.y, 2))
}
func cos(v1, v2 vector) float64 {
	return dot(v1, v2) / (norm(v1) * norm(v2))

}
func problA(p1, p2, p3, p4 punct) {
	v21, v23, v41, v43 := calcVector(p2, p1), calcVector(p2, p3), calcVector(p4, p1), calcVector(p4, p3)
	angle := math.Acos(cos(v21, v23)) + math.Acos(cos(v41, v43))
	if angle == math.Pi {
		fmt.Println("Punctul se afla pe cerc")
	} else {
		if angle < math.Pi {
			fmt.Println("Punctul se afla in afara cercului")
		} else {
			fmt.Println("Punctul se afla in interiorul cercului")
		}
	}
}
func problB(p1, p2, p3, p4 punct) {
	v12, v34, v14, v23 := calcVector(p1, p2), calcVector(p3, p4), calcVector(p1, p4), calcVector(p2, p3)
	n12, n34, n14, n23 := norm(v12), norm(v34), norm(v14), norm(v23)
	if Round(n12, 0.05)+Round(n34, 0.05) == Round(n14, 0.05)+Round(n23, 0.05) {
		fmt.Println("Este circumscriptibil")
	} else {
		fmt.Println("Nu este circumscriptibil")
	}

}
func main() {
	p1, p2, p3, p4 := punct{0, 0}, punct{2, -1}, punct{4, 0}, punct{0, 4}
	problA(p1, p2, p3, p4)
	problB(p1, p2, p3, p4)

}