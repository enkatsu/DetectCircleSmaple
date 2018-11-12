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
  // https://docs.opencv.org/3.4/javadoc/org/opencv/imgproc/Imgproc.html#HoughCircles-org.opencv.core.Mat-org.opencv.core.Mat-int-double-double-
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
