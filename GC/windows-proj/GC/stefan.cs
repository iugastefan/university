namespace GC
{
    using System;
    using System.Collections.Generic;
    using System.Windows;

    public partial class MainWindow
    {

        private partial class Polygon
        {
            public struct Lanturi
            {
                public Point p;

                public int lant;
            }

            //public List<Edge> Diagonale;
            public List<List<Point>> Triangles;

            public List<Edge> DiagonaleAdaugate;

            public void triangulare(List<Point> V)
            {
                var Diagonale = new List<Edge>();
                var Numar_de_puncte = V.Count;
                double yMax = 0, yMin = int.MaxValue;
                int PozYMax = 0, PozYMin = 0;
                Stack<Lanturi> S = new Stack<Lanturi>();
                List<Lanturi> VectorLocal = new List<Lanturi>();
                //List<Edge> Diagonale = new List<Edge>();
                for (int i = 0; i < Numar_de_puncte; i++)
                {
                    if (yMax < V[i].Y)
                    {
                        yMax = V[i].Y;
                        PozYMax = i;
                    }
                    if (yMin > V[i].Y)
                    {
                        yMin = V[i].Y;
                        PozYMin = i;
                    }

                    VectorLocal.Add(new Lanturi { p = new Point() { X = V[i].X, Y = V[i].Y }, lant = 0 });
                }
                if (PozYMax > PozYMin)
                {
                    for (var i = PozYMin; i <= PozYMax; i++)
                    {
                        var lanturi = VectorLocal[i];
                        lanturi.lant = 1;
                        VectorLocal[i] = lanturi;
                    }
                }
                else
                {
                    for (int i = PozYMax; i <= PozYMin; i++)
                    {
                        var lanturi = VectorLocal[i];
                        lanturi.lant = 1;
                        VectorLocal[i] = lanturi;
                    }
                }

                VectorLocal.Sort(
                    delegate (Lanturi l1, Lanturi l2)
                        {
                            if (l1.p.Y > l2.p.Y)
                            {
                                return 1;
                            }

                            if (l1.p.Y < l2.p.Y)
                            {
                                return -1;
                            }

                            if (Math.Abs(l1.p.Y - l2.p.Y) < 0.1 && l1.p.X < l2.p.X)
                            {
                                return 1;
                            }

                            return -1;
                        });

                S.Push(new Lanturi() { p = new Point() { X = VectorLocal[0].p.X, Y = VectorLocal[0].p.Y }, lant = VectorLocal[0].lant });
                S.Push(new Lanturi()
                {
                    p = new Point()
                    {
                        X =
                    VectorLocal[1].p.X,
                        Y = VectorLocal[1].p.Y
                    },
                    lant = VectorLocal[1].lant
                });

                for (int j = 2; j < Numar_de_puncte - 1; j++)
                {

                    if (VectorLocal[j].lant != S.Peek().lant)
                    {
                        while (S.Count != 0)
                        {
                            if (S.Count > 1)
                            {
                                Diagonale.Add(new Edge()
                                {
                                    p1 = new Point()
                                    {
                                        X =
                                        VectorLocal[j].p.X,
                                        Y = VectorLocal[j].p.Y
                                    },
                                    p2 = new Point()
                                    {
                                        X =
                                        S.Peek().p.X,
                                        Y = S.Peek().p.Y
                                    }
                                });
                            }
                            S.Pop();
                        }
                        S.Push(new Lanturi
                        {
                            p = new Point()
                            {
                                X = VectorLocal[j - 1].p.X,
                                Y = VectorLocal[j - 1].p.Y
                            },
                            lant =
                            VectorLocal[j - 1].lant
                        });
                        S.Push(new Lanturi()
                        {
                            p = new Point() { X = VectorLocal[j].p.X, Y = VectorLocal[j].p.Y },
                            lant =
                            VectorLocal[j].lant
                        });
                    }
                    else
                    {
                        Lanturi L = S.Peek();
                        S.Pop();
                        Lanturi L1 = S.Peek();
                        while (S.Count != 0 && this.Angle(VectorLocal[j].p, L.p, L1.p) < Math.PI)
                        {
                            L = S.Peek();
                            S.Pop();
                            Diagonale.Add(new Edge()
                            {
                                p1 = new Point() { X = VectorLocal[j].p.X, Y = VectorLocal[j].p.Y },
                                p2 = new Point() { X = L.p.X, Y = L.p.Y }
                            });
                        }
                        S.Push(L);
                        S.Push(VectorLocal[j]);
                    }
                }
                S.Pop();
                while (S.Count > 1)
                {
                    Diagonale.Add(new Edge()
                    {
                        p1 = new Point()
                        {
                            X = VectorLocal[Numar_de_puncte - 1].p.X,
                            Y =
                            VectorLocal[Numar_de_puncte - 1].p.Y
                        },
                        p2 = new Point()
                        {
                            X = S.Peek().p.X,
                            Y = S.Peek().p.Y
                        }
                    });
                    S.Pop();
                }

                S.Pop();
                this.DiagonaleAdaugate.AddRange(Diagonale);
                var temp = this.DividePoly(V, Diagonale);
                this.Triangles.AddRange(temp);
            }

            public double scalar(Point p1, Point p2)
            {
                return p1.X * p2.Y - p1.Y * p2.X;
            }
            public Point scadere(Point p1, Point p2)
            {
                return new Point()
                {
                    X =
                    p1.X - p2.X,
                    Y = p1.Y - p2.Y
                };
            }

            public bool apartine(List<Point> polygon, Point p)
            {
                Point a = polygon[0], b = polygon[1], c = polygon[2];
                b = this.scadere(b, a);
                c = this.scadere(c, a);
                p = this.scadere(p, a);
                double d = this.scalar(b, c);
                double wa =
                    (p.X * (b.Y - c.Y) + p.Y * (c.X - b.X) + b.X * c.Y - c.X * b.Y) / d;
                double wb = (p.X * c.Y - p.Y * c.X) / d;
                double wc = (p.Y * b.X - p.X * b.Y) / d;
                if (wa >= 0 && wa <= 1 && wb >= 0 && wb <= 1 && wc >= 0 && wc <= 1)
                {
                    return true;
                }

                return false;
            }

            private List<Point> gaseste(List<List<Point>> poligoane, Point p)
            {
                foreach (var x in poligoane)
                {
                    if (this.apartine(x, p))
                    {
                        return x;
                    }
                }

                return new List<Point>()
                           {
                               new Point() { X = 0, Y = 0 }, new Point() { X = 0, Y = 0 }, new Point() { X = 0, Y = 0 }
                           };
            }
        }
    }
}