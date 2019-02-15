namespace GC
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Windows;

    public partial class MainWindow
    {
        public struct Edge : IComparable
        {
            public Point p1;

            public Point p2;

            public int CompareTo(object obj)
            {
                var edge = (Edge)obj;
                var comp = this.p1.Y.CompareTo(edge.p1.Y);
                if (comp == 0)
                {
                    return this.p1.X.CompareTo(edge.p1.X);
                }

                return comp;
            }
        }
        public struct Equation
        {
            public double m;

            public double n;

            public Equation(Edge edge)
            {
                var b = edge.p1;
                var a = edge.p2;
                this.m = (b.Y - a.Y) / (b.X - a.X);
                this.n = a.Y - this.m * a.X;
            }
            public double distance(Point p)
            {
                var d = Math.Abs(p.Y - this.m * p.X - this.n) / Math.Sqrt(1 + Math.Pow(this.m, 2));
                return d;
            }
        }
        private struct MyPoint
        {
            public Point Point;

            public int Tip;

            public Edge ledge;

            public Edge redge;

            public MyPoint(Point point, int tip)
            {
                this.Point = point;
                this.Tip = tip;
                this.ledge = new Edge();
                this.redge = new Edge();
            }
        }
        private partial class Polygon
        {
            public Point point;

            private List<Edge> edges;

            public List<List<Point>> monotoneComponents;

            private SortedSet<Edge> T;

            private Dictionary<Edge, MyPoint> helper;

            public List<MyPoint> Points
            {
                get; set;
            }

            public void AddPointToPolygon(Point point, int tip)
            {
                this.Points.Add(new MyPoint(point, tip));
            }

            public void AddEdge(Edge edge)
            {
                this.edges.Add(edge);
            }

            public void SetPoint(double x, double y)
            {
                this.point.X = x;
                this.point.Y = y;
            }

            public Polygon()
            {
                this.monotoneComponents = new List<List<Point>>();
                this.Points = new List<MyPoint>();
                this.point = new Point(0, 0);
                this.edges = new List<Edge>();
                this.helper = new Dictionary<Edge, MyPoint>();
                //this.Diagonale = new List<Edge>();
                this.Triangles = new List<List<Point>>();
                this.DiagonaleAdaugate = new List<Edge>();
            }

            public int angleHelper(MyPoint p)
            {
                var cn = 0;
                for (var i = 0; i < this.Points.Count; i++)
                {
                    if (i == this.Points.Count - 1)
                    {
                        if (this.Points[i].Point.Y <= p.Point.Y && this.Points[0].Point.Y > p.Point.Y || this.Points[i].Point.Y > p.Point.Y && this.Points[0].Point.Y <= p.Point.Y)
                        {
                            var vt = (p.Point.Y - this.Points[i].Point.Y) / (this.Points[0].Point.Y - this.Points[i].Point.Y);
                            if (p.Point.X < this.Points[i].Point.X + vt * (this.Points[0].Point.X - this.Points[i].Point.X))
                            {
                                cn++;
                            }
                        }
                    }
                    else
                    {
                        if (this.Points[i].Point.Y <= p.Point.Y && this.Points[i + 1].Point.Y > p.Point.Y || this.Points[i].Point.Y > p.Point.Y && this.Points[i + 1].Point.Y <= p.Point.Y)
                        {
                            var vt = (p.Point.Y - this.Points[i].Point.Y) / (this.Points[i + 1].Point.Y - this.Points[i].Point.Y);
                            if (p.Point.X < this.Points[i].Point.X + vt * (this.Points[i + 1].Point.X - this.Points[i].Point.X))
                            {
                                cn++;
                            }
                        }
                    }
                }

                return cn & 1;
            }

            public double Angle(MyPoint a, MyPoint b, MyPoint c)
            {
                MyPoint ba = new MyPoint(), bc = new MyPoint();
                ba.Point.X = b.Point.X - a.Point.X;
                ba.Point.Y = b.Point.Y - a.Point.Y;
                bc.Point.X = b.Point.X - c.Point.X;
                bc.Point.Y = b.Point.Y - c.Point.Y;
                var cos = ba.Point.X * bc.Point.X + ba.Point.Y * bc.Point.Y;
                var n = Math.Sqrt(Math.Pow(ba.Point.X, 2) + Math.Pow(ba.Point.Y, 2))
                           * Math.Sqrt(Math.Pow(bc.Point.X, 2) + Math.Pow(bc.Point.Y, 2));
                cos = cos / n;
                if (this.angleHelper(b) == 1)
                {
                    return 2 * Math.PI - Math.Acos(cos);
                }

                return Math.Acos(cos);
            }
            public double Angle(Point a, Point b, Point c)
            {
                Point ba = new Point(), bc = new Point();
                ba.X = b.X - a.X;
                ba.Y = b.Y - a.Y;
                bc.X = b.X - c.X;
                bc.Y = b.Y - c.Y;
                var cos = ba.X * bc.X + ba.Y * bc.Y;
                var n = Math.Sqrt(Math.Pow(ba.X, 2) + Math.Pow(ba.Y, 2))
                           * Math.Sqrt(Math.Pow(bc.X, 2) + Math.Pow(bc.Y, 2));
                cos = cos / n;
                var bn = new MyPoint(b, 0);
                if (this.angleHelper(bn) == 1)
                {
                    return 2 * Math.PI - Math.Acos(cos);
                }

                return Math.Acos(cos);
            }

            public int Tip(MyPoint st, MyPoint p, MyPoint dr)
            {
                if (st.Point.Y <= p.Point.Y && p.Point.Y >= dr.Point.Y)
                {
                    if (this.Angle(st, p, dr) < Math.PI)
                    {
                        return 1; // start vertex
                    }

                    return 2; // split vertex
                }
                if (st.Point.Y >= p.Point.Y && p.Point.Y <= dr.Point.Y)
                {
                    if (this.Angle(st, p, dr) < Math.PI)
                    {
                        return 3; // end vertex
                    }

                    return 4; // merge vertex
                }

                return 5; // regular vertex
            }

            public void MakeMonotone()
            {
                this.D = new LinkedList<Edge>();
                this.T = new SortedSet<Edge>();
                var Q = new List<MyPoint>(this.Points);
                Q.Sort(
                    delegate (MyPoint p1, MyPoint p2)
                        {
                            var comp = p2.Point.Y.CompareTo(p1.Point.Y);

                            if (comp == 0)
                            {
                                return p1.Point.X.CompareTo(p2.Point.X);
                            }

                            return comp;
                        });
                foreach (var vertex in Q)
                {
                    this.HandleVertex(vertex);
                }

                this.monotoneComponents = this.DividePoly(new List<MyPoint>(this.Points), new List<Edge>(this.D));

            }
            public List<List<Point>> DividePoly(List<Point> poly, List<Edge> edges)
            {
                var poly2 = new List<MyPoint>();
                foreach (var point1 in poly)
                {
                    var myPoint
                        = new MyPoint() { Point = point1, Tip = 0 };
                    poly2.Add(myPoint);
                }

                return this.DividePoly(poly2, edges);
            }

            public List<List<Point>> DividePoly(List<MyPoint> poly, List<Edge> edges)
            {
                var components = new List<List<Point>>();
                var polyReversed = new List<MyPoint>(poly);
                polyReversed.Reverse(0, polyReversed.Count - 0);
                List<Point> temp;
                while (edges.Count != 0)
                {
                    var pos = poly.Find(x => edges.Exists(y => y.p1 == x.Point || y.p2 == x.Point));
                    var pos2 = polyReversed.Find(
                        x => edges.Exists(
                            y => (y.p1 == x.Point && y.p2 == pos.Point) || (y.p2 == x.Point && y.p1 == pos.Point)));
                    var comp1 = poly.GetRange(0, poly.FindIndex(x => x.Point == pos.Point) + 1);
                    var comp2 = polyReversed.GetRange(0, polyReversed.FindIndex(x => x.Point == pos2.Point) + 1);
                    comp2.Reverse();
                    var comp = new List<MyPoint>(comp1);
                    comp.AddRange(comp2);
                temp = new List<Point>();
                foreach (var myPoint in comp)
                {
                    var tempPoint = new Point(myPoint.Point.X, myPoint.Point.Y);
                    temp.Add(tempPoint);
                }
                    components.Add(temp);
                    if (edges.Contains(new Edge()
                    {
                        p1 = pos.Point,
                        p2 = pos2.Point
                    }))
                    {
                        edges.Remove(new Edge() { p1 = pos.Point, p2 = pos2.Point });
                    }
                    else
                    {
                        edges.Remove(new Edge() { p1 = pos2.Point, p2 = pos.Point });
                    }

                    poly.RemoveRange(0, poly.FindIndex(x => x.Point == pos.Point));
                    poly.RemoveRange(
                        poly.FindIndex(x => x.Point == pos2.Point) + 1,
                        poly.Count - poly.FindIndex(x => x.Point == pos2.Point) - 1);
                    polyReversed = new List<MyPoint>(poly);
                    polyReversed.Reverse(0, polyReversed.Count);
                }

                temp = new List<Point>();
                foreach (var myPoint in poly)
                {
                    var tempPoint = new Point(myPoint.Point.X, myPoint.Point.Y);
                    temp.Add(tempPoint);
                }
                components.Add(temp);
                return components;
            }

            private void HandleVertex(MyPoint vertex)
            {
                switch (vertex.Tip)
                {
                    case 1:
                        this.HandleStartVertex(vertex);
                        break;
                    case 2:
                        this.HandleSplitVertex(vertex);
                        break;
                    case 3:
                        this.HandleEndVertex(vertex);
                        break;
                    case 4:
                        this.HandleMergeVertex(vertex);
                        break;
                    default:
                        this.HandleRegularVertex(vertex);
                        break;
                }
            }

            private void HandleRegularVertex(MyPoint vertex)
            {
                var pos = this.Points.FindIndex(x => x.Equals(vertex));
                MyPoint lastvertex;
                if (pos == 0)
                {
                    lastvertex = this.Points[this.Points.Count - 1];
                }
                else
                {
                    lastvertex = this.Points[pos - 1];
                }
                if (vertex.Point.Y >= lastvertex.Point.Y)
                {
                    // The polygon is on the right
                    var e0 = vertex.ledge;
                    var e1 = vertex.redge;
                    if (this.helper[e0].Tip == 4)
                    {
                        this.D.AddLast(new Edge() { p1 = this.helper[e0].Point, p2 = vertex.Point });
                    }

                    this.T.Remove(e0);
                    this.T.Add(e1);
                    this.helper[e1] = vertex;
                }
                else
                {
                    var query = from val in this.T where (val.p2.Y >= vertex.Point.Y && val.p1.Y <= vertex.Point.Y) select val;
                    var dist = double.MaxValue;
                    var e = new Edge();
                    foreach (var edge in query)
                    {
                        var eq = new Equation(edge);
                        var d = eq.distance(vertex.Point);
                        if (d > 0 && d < dist)
                        {
                            e = edge;
                            dist = d;
                        }
                    }
                    this.T.Add(e);
                    if (this.helper[e].Tip == 4)
                    {
                        this.D.AddLast(new Edge() { p1 = this.helper[e].Point, p2 = vertex.Point });
                    }

                    this.helper[e] = vertex;

                }
            }

            private void HandleMergeVertex(MyPoint vertex)
            {
                var e = vertex.ledge;
                if (this.helper[e].Tip == 4)
                {
                    this.D.AddLast(new Edge() { p1 = this.helper[e].Point, p2 = vertex.Point });
                }

                this.T.Remove(e);

                var query = from val in this.T where (val.p1.Y <= vertex.Point.Y && val.p2.Y >= vertex.Point.Y) select val;
                var dist = double.MaxValue;
                var e1 = new Edge();
                foreach (var edge in query)
                {
                    var eq = new Equation(edge);
                    var d = eq.distance(vertex.Point);
                    if (d > 0 && d < dist)
                    {
                        e1 = edge;
                        dist = d;
                    }
                }
                if (this.helper[e1].Tip == 4)
                {
                    this.D.AddLast(new Edge() { p1 = this.helper[e1].Point, p2 = vertex.Point });
                }

                this.helper[e1] = vertex;
            }

            private void HandleSplitVertex(MyPoint vertex)
            {
                var query = from val in this.T where (val.p1.Y <= vertex.Point.Y && val.p2.Y >= vertex.Point.Y) select val;
                var dist = double.MaxValue;
                var e = new Edge();
                foreach (var edge in query)
                {
                    var eq = new Equation(edge);
                    var d = eq.distance(vertex.Point);
                    if (Math.Abs(d) < 1)
                    {
                        break;
                    }
                    if (d > 0 && d < dist)
                    {
                        e = edge;
                        dist = d;
                    }
                }

                this.D.AddLast(new Edge() { p1 = this.helper[e].Point, p2 = vertex.Point });
                this.helper[e] = vertex;
                var e1 = vertex.redge;
                this.T.Add(e1);
                this.helper[e1] = vertex;

            }

            private void HandleEndVertex(MyPoint vertex)
            {
                var e = vertex.ledge;
                if (this.helper[e].Tip == 4)
                {
                    this.D.AddLast(new Edge() { p1 = this.helper[e].Point, p2 = vertex.Point });
                }

                this.T.Remove(e);
            }

            private void HandleStartVertex(MyPoint vertex)
            {
                this.T.Add(vertex.redge);
                this.helper[vertex.redge] = vertex;
            }

            public LinkedList<Edge> D
            {
                get; set;
            }




        }
    }
}