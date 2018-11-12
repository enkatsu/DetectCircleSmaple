import gab.opencv.*;
import org.opencv.core.*;
import org.opencv.imgproc.*;

OpenCV opencv;
Mat circles;

void setup() {
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  PImage src = loadImage("buttons.png");
  size(200, 200);
  opencv = new OpenCV(this, src);
  circles = new Mat();
  /**
   http://opencv.jp/opencv-2svn/cpp/feature_detection.html#cv-houghcircles
   Imgproc.HoughCircles(Mat image, Mat circles, int method, double dp, double minDist, double param1=100, double param2=100, int minRadius=0, int maxRadius=0)
   image:      8ビット，シングルチャンネル，グレースケールの入力画像．
   circles:    検出された円を出力するベクトル．各ベクトルは，3要素の浮動小数点型ベクトル (x, y, radius) としてエンコードされます．
   method:     現在のところ， CV_HOUGH_GRADIENT メソッドのみが実装されています．基本的には 2段階ハフ変換 で，これについては Yuen90 で述べられています．
   dp:         画像分解能に対する投票分解能の比率の逆数．例えば， dp=1 の場合は，投票空間は入力画像と同じ分解能をもちます．また dp=2 の場合は，投票空間の幅と高さは半分になります．
   minDist:    検出される円の中心同士の最小距離．このパラメータが小さすぎると，正しい円の周辺に別の円が複数誤って検出されることになります．逆に大きすぎると，検出できない円がでてくる可能性があります．
   param1:     手法依存の 1 番目のパラメータ．CV_HOUGH_GRADIENT の場合は， Canny() エッジ検出器に渡される2つの閾値の内，大きい方の閾値を表します（小さい閾値は，この値の半分になります）．
   param2:     手法依存の 2 番目のパラメータ．CV_HOUGH_GRADIENT の場合は，円の中心を検出する際の投票数の閾値を表します．これが小さくなるほど，より多くの誤検出が起こる可能性があります．より多くの投票を獲得した円が，最初に出力されます．
   minRadius:  円の半径の最小値．
   maxRadius:  円の半径の最大値．
   */
  Imgproc.HoughCircles(opencv.matGray, circles, Imgproc.CV_HOUGH_GRADIENT, 1, 20);
}

void draw() {
  // image(opencv.getOutput(), 0, 0);
  image(opencv.getInput(), 0, 0);
  fill(255, 0, 0, 100);
  drwCircles(circles);
}

void drwCircles(Mat circles) {
  double[] data;
  double rho;
  Point pt = new Point();
  for (int i = 0; i < circles.cols(); i++) {
    data = circles.get(0, i);
    pt.x = data[0];
    pt.y = data[1];
    rho = data[2];
    ellipse((float)pt.x, (float)pt.y, (float)rho * 2, (float)rho * 2);
  }
}
