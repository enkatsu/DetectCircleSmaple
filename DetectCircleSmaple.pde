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
  drawCircles(circles);
}

void drawCircles(Mat circles) {
  pushStyle();
  ellipseMode(RADIUS);
  for (int i = 0; i < circles.cols(); i++) {
    double[] data = circles.get(0, i);
    float x = (float)data[0];
    float y = (float)data[1];
    float rad = (float)data[2];
    ellipse(x, y, rad, rad);
  }
  popStyle();
}
