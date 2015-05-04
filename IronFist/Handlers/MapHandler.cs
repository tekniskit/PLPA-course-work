using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using IronScheme;

namespace IronFist.Handlers
{
    public class MapHandler
    {
        private readonly List<List<string>> _mapList;
        private readonly Canvas _mapCanvas;
        private readonly Dictionary<string, SolidColorBrush> _boxDictionary; 

        public MapHandler(Canvas mapCanvas)
        {
            _mapCanvas = mapCanvas;

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
                {"0", Brushes.Yellow},
                {"1", Brushes.Yellow},
                {"2", Brushes.Yellow},
                {"3", Brushes.Yellow},
                {"4", Brushes.Yellow},
                {"!", Brushes.Red},
                {"s", Brushes.Red},
                {"/", Brushes.Gray},
            };
        }

        public void DrawMap()
        {
            const int boxDim = 15;
            var row = _mapList.Count;
            var column = _mapList.First().Count;
            FirstMatrixParse(row, column, boxDim);
            SecondMatrixParse(row, column, boxDim);
            SetRobot();
        }

        public void SetRobot()
        {
            var robot = AddToCanvas(21*15, 11*15, 15, Brushes.AliceBlue);
            //_mapCanvas.Children.Remove(robot);
        }

        private void FirstMatrixParse(int rowCount, int columnCount, int figureDim)
        {
            Console.WriteLine(rowCount);
            for (var i = 0; i < rowCount; i++)
            {
                for (var j = 0; j < columnCount; j++)
                {
                    var posY = i * figureDim;
                    var posX = j * figureDim;
                    var sym = _mapList.ElementAt(i).ElementAt(j);
                    AddToCanvas(posX, posY, figureDim, _boxDictionary.ContainsKey(sym) ? _boxDictionary[sym] : Brushes.White);
                }
            }
        }

        private void SecondMatrixParse(int rowCount, int columnCount, int figureDim)
        {
            for (var i = 0; i < rowCount; i++)
            {
                for (var j = 0; j < columnCount; j++)
                {
                    var sym = _mapList.ElementAt(i).ElementAt(j);
                    if (sym == ">" || sym == "<")
                    {
                        var rightIsNumeric = Regex.IsMatch(_mapList.ElementAt(i).ElementAt(j + 1), @"^\d+$");
                        var posArrowY = i * figureDim;
                        var posArrowX = (rightIsNumeric ? j + 1 : j - 1) * figureDim;
                        var imageBrush = new ImageBrush();
                        var url = "../../Images/" + (sym == ">" ? "arrow-right.png" : "arrow-left.png");
                        imageBrush.ImageSource = new BitmapImage(new Uri(@url, UriKind.RelativeOrAbsolute));
                        AddToCanvas(posArrowX, posArrowY, figureDim, imageBrush);
                    }
                    else if (sym == "v" || sym == "^")
                    {
                        var rightIsNumeric = Regex.IsMatch(_mapList.ElementAt(i + 1).ElementAt(j), @"^\d+$");
                        var posArrowX = j * figureDim;
                        var posArrowY = (rightIsNumeric ? i + 1 : i - 1) * figureDim;
                        var imageBrush = new ImageBrush();
                        var url = "../../Images/" + (sym == "v" ? "arrow-down.png" : "arrow-up.png");
                        imageBrush.ImageSource = new BitmapImage(new Uri(@url, UriKind.RelativeOrAbsolute));
                        AddToCanvas(posArrowX, posArrowY, figureDim, imageBrush);
                    }
                }
            }
        }

        private Rectangle AddToCanvas(int posX, int posY, int figureDim, Brush figureFill)
        {
            var rect = new Rectangle
            {
                Fill = figureFill,
                Width = figureDim,
                Height = figureDim,
                //Stroke = Brushes.Black,
                //StrokeThickness = 0.5
            };

            Canvas.SetLeft(rect, posX);
            Canvas.SetTop(rect, posY);
            _mapCanvas.Children.Add(rect);

            return rect;
        }
    }
}
