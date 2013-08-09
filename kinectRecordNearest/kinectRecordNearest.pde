import SimpleOpenNI.*;
SimpleOpenNI kinect;

int closestValue;
int closestX;
int closestY;
boolean toggle = false;
float startTime;

PrintWriter output;

int[] depthValues;

void setup() 
{
  size(640, 480); 
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  output = createWriter("positions.txt");
  println("Left-click to record.");
  println("Right-click to end.");
}

void draw() 
{
  closestValue = 8000;
  kinect.update();
  depthValues = kinect.depthMap();
  for (int y = 0; y < 480; y++) {
    for (int x = 0; x < 640; x++) {
      int i = x + y*640;
      int currentDepthValue = depthValues[i];
      if (currentDepthValue > 0 && currentDepthValue < closestValue) {
        closestValue = currentDepthValue;
        closestX = x;
        closestY = y;
      }
    }
  }

  image(kinect.depthImage(), 0, 0);

  if (toggle == false) {
    fill(255, 0, 0);
  }
  if (toggle == true) {
    fill(255, 255, 0);
    output.print(millis()-startTime);
    output.print(",");
    output.print(closestX);
    output.print(",");
    output.print(closestY);
    output.print(",");
    output.println(closestValue);
  }
  ellipse(closestX, closestY, 25, 25);
}


void mouseClicked() {
  if (mouseButton == LEFT) {
    startTime = millis();
    /*
    output.print("time");
    output.print(",");
    output.print("x");
    output.print(",");
    output.print("y");
    output.print(",");
    output.println("z");
    */
    toggle = true;
  }
  if (mouseButton == RIGHT) {
    output.flush();
    output.close();
    exit();
  }
}

