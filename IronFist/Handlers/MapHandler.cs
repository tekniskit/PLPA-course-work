using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using IronScheme;

namespace IronFist.Handlers
{
    public class MapHandler
    {
        private Rectangle _robot;
        private const int FirgureDim = 15;
        private readonly List<List<string>> _mapList;
        private readonly Canvas _mapCanvas;
        private readonly Dictionary<string, SolidColorBrush> _boxDictionary;
        private readonly ImageBrush _eastImage;
        private readonly ImageBrush _northImage;
        private readonly ImageBrush _westImage;
        private readonly ImageBrush _southImage;

        public MapHandler(Canvas mapCanvas)
        {
            _mapCanvas = mapCanvas;
            _robot = null;

            // Load file
            var factory = "factory".Eval();

            _mapList = new List<List<string>>();
            foreach (var row in (IEnumerable)factory)
            {
                var interm = new List<string>();
                interm.AddRange(from object item in (IEnumerable) row select item.ToString());
                _mapList.Add(interm);
            }

            _boxDictionary = new Dictionary<string, SolidColorBrush>
            {
                {"-", Brushes.LightGray},
                {"*", Brushes.LimeGreen},
                {"<", Brushes.LimeGreen},
                {">", Brushes.LimeGreen},
                {"^", Brushes.LimeGreen},
                {"v", Brushes.LimeGreen},
                {"1", Brushes.Yellow},
                {"2", Brushes.Yellow},
                {"3", Brushes.Yellow},
                {"4", Brushes.Yellow},
                {"5", Brushes.Yellow},
                {"!", Brushes.Red},
                {"s", Brushes.Red},
                {"/", Brushes.Gray},
            };

            _eastImage = new ImageBrush { ImageSource = new BitmapImage(new Uri(@"../../Images/robot-0.png", UriKind.RelativeOrAbsolute)) };
            _northImage = new ImageBrush { ImageSource = new BitmapImage(new Uri(@"../../Images/robot-1.png", UriKind.RelativeOrAbsolute)) };
            _westImage = new ImageBrush { ImageSource = new BitmapImage(new Uri(@"../../Images/robot-2.png", UriKind.RelativeOrAbsolute)) };
            _southImage = new ImageBrush { ImageSource = new BitmapImage(new Uri(@"../../Images/robot-3.png", UriKind.RelativeOrAbsolute)) };

            DrawMap();
            InitRobotPost();
        }

        private void InitRobotPost()
        {
            // Set initial robot position and direction
            int robotPosX;
            int robotPosY;
            int robotDirection;

            int.TryParse("x".Eval().ToString(), out robotPosX);
            int.TryParse("y".Eval().ToString(), out robotPosY);
            int.TryParse("direction".Eval().ToString(), out robotDirection);

            SetRobot(robotPosX, robotPosY, robotDirection);
        }

        private void DrawMap()
        {
            var row = _mapList.Count;
            var column = _mapList.First().Count;
            FirstMatrixParse(row, column);
            SecondMatrixParse(row, column);
            AddWorkStationNumber(1);
        }

        private void AddWorkStationNumber(int num)
        {
            var ws = string.Format("(workstation-num {0})", num).Eval() as IronScheme.Runtime.Cons;
            if (ws == null) return;
            var cdr = (ws.cdr as IronScheme.Runtime.Cons);
            if (cdr == null) return;
            var x = int.Parse(ws.car.ToString());
            var y = int.Parse(cdr.car.ToString());
            AddToCanvas(x, y, Brushes.Yellow, num);
        }

        public void SetRobot(int x, int y, int direction)
        {
            if (_robot != null)
                _mapCanvas.Children.Remove(_robot);

            ImageBrush imageBrush;

            switch (direction)
            {
                case 0:
                    imageBrush = _eastImage;
                    break;
                case 1:
                    imageBrush = _northImage;
                    break;
                case 2:
                    imageBrush = _westImage;
                    break;
                case 3:
                    imageBrush = _southImage;
                    break;
                default:
                    imageBrush = _eastImage;
                    break;
            }

            _robot = AddToCanvas(x, y, imageBrush);
        }

        private void FirstMatrixParse(int rowCount, int columnCount)
        {
            for (var i = 0; i < rowCount; i++)
            {
                for (var j = 0; j < columnCount; j++)
                {
                    var sym = _mapList.ElementAt(i).ElementAt(j);
                    AddToCanvas(j, i, _boxDictionary.ContainsKey(sym) ? _boxDictionary[sym] : Brushes.White);
                }
            }
        }

        private void SecondMatrixParse(int rowCount, int columnCount)
        {
            for (var i = 0; i < rowCount; i++)
            {
                for (var j = 0; j < columnCount; j++)
                {
                    var sym = _mapList.ElementAt(i).ElementAt(j);
                    if (sym == ">" || sym == "<")
                    {
                        var rightIsNumeric = Regex.IsMatch(_mapList.ElementAt(i).ElementAt(j + 1), @"^\d+$");
                        var posArrowY = i;
                        var posArrowX = (rightIsNumeric ? j + 1 : j - 1);
                        var imageBrush = new ImageBrush();
                        var url = "../../Images/" + (sym == ">" ? "arrow-right.png" : "arrow-left.png");
                        imageBrush.ImageSource = new BitmapImage(new Uri(@url, UriKind.RelativeOrAbsolute));
                        AddToCanvas(posArrowX, posArrowY, imageBrush);
                    }
                    else if (sym == "v" || sym == "^")
                    {
                        var rightIsNumeric = Regex.IsMatch(_mapList.ElementAt(i + 1).ElementAt(j), @"^\d+$");
                        var posArrowX = j;
                        var posArrowY = (rightIsNumeric ? i + 1 : i - 1);
                        var imageBrush = new ImageBrush();
                        var url = "../../Images/" + (sym == "v" ? "arrow-down.png" : "arrow-up.png");
                        imageBrush.ImageSource = new BitmapImage(new Uri(@url, UriKind.RelativeOrAbsolute));
                        AddToCanvas(posArrowX, posArrowY, imageBrush);
                    }
                    else if (Regex.IsMatch(sym, @"\d"))
                    {
                        var num = int.Parse(sym);
                        AddWorkStationNumber(num);
                    }
                }
            }
        }

        private Rectangle AddToCanvas(int posX, int posY, Brush figureFill, int num = 0)
        {
            var rect = new Rectangle
            {
                Fill = figureFill,
                Width = FirgureDim,
                Height = FirgureDim,
                Stroke = Brushes.Black,
                StrokeThickness = 0.5,
                
            };

            if (num != 0)
            {
                var grid = new Grid
                {
                    MaxHeight = FirgureDim,
                    MaxWidth = FirgureDim
                };

                grid.Children.Add(rect);
                grid.Children.Add(new TextBlock
                {
                    Text = num.ToString(),
                    TextAlignment = TextAlignment.Center
                });

                Canvas.SetLeft(grid, posX * FirgureDim);
                Canvas.SetTop(grid, posY * FirgureDim);
                _mapCanvas.Children.Add(grid);
            }
            else
            {
                Canvas.SetLeft(rect, posX * FirgureDim);
                Canvas.SetTop(rect, posY * FirgureDim);
                _mapCanvas.Children.Add(rect);
            }

            return rect;
        }
    }
}
