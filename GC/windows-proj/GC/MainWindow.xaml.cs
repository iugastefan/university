namespace GC
{
    using System;
    using System.Collections.Generic;
    using System.Windows;
    using System.Windows.Controls;
    using System.Windows.Input;
    using System.Windows.Media;
    using System.Windows.Shapes;

    public partial class MainWindow
    {
        private Polygon polygon;
        private Ellipse ellipse;
        private class Command : ICommand
        {
            public event EventHandler CanExecuteChanged;

            public bool CanExecute(object parameter)
            {
                return true;
            }

            public void Execute(object parameter)
            {
                var window = (MainWindow)parameter;
                window.Canvas.Children.Clear();
                var canvas = window.Setup();
                window.DrawPolygon(canvas);
            }
        }

        private string text;

        public MainWindow()
        {
            this.InitializeComponent();
            this.TextBox.Text = "4 6\n6 7\n10 5\n6 2\n2 6\n6 10\n13 5\n6 0\n5 1\n11 5\n6 8\n3 6\n6 3\n8 5\n6 6\n6 4";
            this.text = this.TextBox.Text;
            this.TextBox.Text += "\n\n20 20";

            this.Button.Content = "Draw";
            this.Button.Command = new Command();
            this.Button.CommandParameter = this;

            //this.Setup();
                var canvas = Setup();
                DrawPolygon(canvas);
        }

        private string[] BoxStrings()
        {
            char[] separators = { '\n', '\t', '\r', ' ' };
            return this.TextBox.Text.Split(separators, StringSplitOptions.RemoveEmptyEntries);
        }

        private Canvas Setup()
        {
            var myCanvas = new Canvas { Width = this.Canvas.Width, Height = this.Canvas.Height };
            Canvas.SetTop(myCanvas, 200);
            Canvas.SetLeft(myCanvas, 200);
            this.Canvas.Background = Brushes.Gray;
            this.Canvas.Children.Add(myCanvas);
            this.ResizeMode = ResizeMode.NoResize;

            // Axis
            myCanvas.Children.Add(new Line() { X1 = 0, Y1 = 200, X2 = 0, Y2 = -200, Stroke = Brushes.Black });
            myCanvas.Children.Add(new Line() { X1 = -200, Y1 = 0, X2 = 200, Y2 = 0, Stroke = Brushes.Black });

            this.ellipse = new Ellipse();
            Canvas.SetTop(this.ellipse, 0);
            Canvas.SetLeft(this.ellipse, 0);
            this.ellipse.Width = 5;
            this.ellipse.Height = 5;
            this.ellipse.Fill = Brushes.Black;

            myCanvas.Children.Add(this.ellipse);

            return myCanvas;
        }

        private void DrawPolygon(Canvas myCanvas)
        {
            var coordinate = this.BoxStrings();
            this.polygon = new Polygon();
            var poly = new System.Windows.Shapes.Polygon();
            for (var i = 0; i < coordinate.Length - 2; i += 2)
            {
                var x = 15 * Convert.ToDouble(coordinate[i]);
                var y = 15 * -Convert.ToDouble(coordinate[i + 1]);
                var point = new Point { X = x / 15, Y = y / 15 };
                var point2 = new Point { X = x, Y = y };
                poly.Points.Add(point2);
                point.Y = -point.Y;
                this.polygon.AddPointToPolygon(point, 0);
            }

            var xp = Convert.ToDouble(coordinate[coordinate.Length - 2]);
            var yp = Convert.ToDouble(coordinate[coordinate.Length - 1]);
            this.polygon.point = new Point(xp, yp);

            for (var i = 0; i < this.polygon.Points.Count; i++)
            {
                if (i == 0)
                {
                    var polygonPoint = this.polygon.Points[i];
                    polygonPoint.Tip = this.polygon.Tip(
                        this.polygon.Points[this.polygon.Points.Count - 1],
                        this.polygon.Points[i],
                        this.polygon.Points[i + 1]);
                    this.polygon.Points[i] = polygonPoint;
                }
                else if (i == this.polygon.Points.Count - 1)
                {
                    var polygonPoint = this.polygon.Points[i];
                    polygonPoint.Tip = this.polygon.Tip(
                        this.polygon.Points[i - 1],
                        this.polygon.Points[i],
                        this.polygon.Points[0]);
                    this.polygon.Points[i] = polygonPoint;
                }
                else
                {
                    var polygonPoint = this.polygon.Points[i];
                    polygonPoint.Tip = this.polygon.Tip(
                        this.polygon.Points[i - 1],
                        this.polygon.Points[i],
                        this.polygon.Points[i + 1]);
                    this.polygon.Points[i] = polygonPoint;
                }
            }

            for (var i = 0; i < this.polygon.Points.Count; i++)
            {
                Edge ledge;
                Edge redge;
                if (i != this.polygon.Points.Count - 1)
                {
                    ledge = new Edge() { p1 = this.polygon.Points[i].Point, p2 = this.polygon.Points[i + 1].Point };
                    if (i == 0)
                    {
                        redge = new Edge() { p1 = this.polygon.Points[this.polygon.Points.Count - 1].Point, p2 = this.polygon.Points[i].Point };

                    }
                    else
                    {
                        redge = new Edge() { p1 = this.polygon.Points[i - 1].Point, p2 = this.polygon.Points[i].Point };
                    }
                }
                else
                {
                    ledge = new Edge() { p1 = this.polygon.Points[i].Point, p2 = this.polygon.Points[0].Point };
                    redge = new Edge() { p1 = this.polygon.Points[i - 1].Point, p2 = this.polygon.Points[i].Point };
                }

                var polygonPoint = this.polygon.Points[i];
                polygonPoint.ledge = ledge;
                polygonPoint.redge = redge;
                this.polygon.Points[i] = polygonPoint;
                this.polygon.AddEdge(ledge);
            }

            poly.Stroke = Brushes.Black;
            // poly.Fill = Brushes.White;
            myCanvas.Children.Add(poly);

            this.polygon.MakeMonotone();
            foreach (var edge in this.polygon.D)
            {
                var line = new Line();
                line.X1 = edge.p1.X * 15;
                line.Y1 = -edge.p1.Y * 15;
                line.X2 = edge.p2.X * 15;
                line.Y2 = -edge.p2.Y * 15;
                line.Stroke = Brushes.Green;
                myCanvas.Children.Add(line);
            }

            foreach (var component in this.polygon.monotoneComponents)
            {
                this.polygon.triangulare(component);
                foreach (var edge in this.polygon.DiagonaleAdaugate)
                {
                    var line = new Line();
                    line.X1 = edge.p1.X * 15;
                    line.Y1 = -edge.p1.Y * 15;
                    line.X2 = edge.p2.X * 15;
                    line.Y2 = -edge.p2.Y * 15;
                    line.Stroke = Brushes.Blue;
                    myCanvas.Children.Add(line);
                }

            }

            foreach (var triangle in this.polygon.Triangles)
            {
                if (this.polygon.apartine(triangle, this.polygon.point))
                {

                    var tri = new System.Windows.Shapes.Polygon();
                    foreach (var point in triangle)
                    {
                        var temp = new Point(point.X * 15, point.Y * -15);
                        tri.Points.Add(temp);
                    }
                    tri.Fill = Brushes.Red;
                    tri.StrokeThickness = 5;
                    myCanvas.Children.Insert(0, tri);
                    break;
                }
            }
        }

        private void Canvas_OnPreviewMouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            var y = e.GetPosition(this.Canvas).Y - 203;
            var x = e.GetPosition(this.Canvas).X - 203;
            Canvas.SetTop(this.ellipse, y);
            Canvas.SetLeft(this.ellipse, x);
            this.polygon?.SetPoint(x, y);
            var strings = this.BoxStrings();
            var stringList = new List<string>(strings);
            stringList = stringList.GetRange(0, stringList.Count - 2);
            this.TextBox.Text = string.Empty;
            for (var i = 0; i < stringList.Count; i += 2)
            {
                this.TextBox.Text += stringList[i] + " " + stringList[i + 1] + "\n";
            }
            this.TextBox.Text += "\n\n" + x / 15 + ' ' + y / -15;
        }
    }
}
