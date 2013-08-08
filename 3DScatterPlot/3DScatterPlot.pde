import peasy.*;

String x = "x";
PFont f;
PeasyCam cam;
ArrayList <PVector>pointList;   
PVector pointSelected;

int maxX = 0;
int maxY = 0;
int maxZ = 0;

int minX = 10000;
int minY = 10000;
int minZ = 10000;

int range = 0;
int a = 0;

void setup() {
  size(700, 700, P3D);
  f = createFont("ArialMT-100", 100, true);
  textAlign(CENTER);
  textFont(f, 50);
  cam = new PeasyCam(this, width/2, width/2, width/2, 800);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(2000);

  pointList = new ArrayList();
  importTextFile();
  smooth();

  //Determine min and max

  for (int i=0; i < pointList.size(); i++) {
    PVector R = pointList.get(i);
    if (R.x > maxX) {
      maxX = (int)R.x;
    }
    if (R.x < minX) {
      minX = (int)R.x;
    }

    if (R.y > maxY) {
      maxY = (int)R.y;
    }
    if (R.y < minY) {
      minY = (int)R.y;
    }

    if (R.z > maxZ) {
      maxZ = (int)R.z;
    }
    if (R.z < minZ) {
      minZ = (int)R.z;
    }
  }


  if (maxX - minX > range) {
    range = maxX - minX;
  }
  if (maxY - minY > range) {
    range = maxY - minY;
  }
  if (maxZ - minZ > range) {
    range = maxZ - minZ;
  }
}

void draw() {
  background(255);
  stroke(0);
  strokeWeight(2);
  line(0, 0, 0, width, 0, 0);
  line(0, 0, 0, 0, width, 0);
  line(0, 0, 0, 0, 0, width);
  fill(0);
  text(x, width-10, -5);
  text("y", -15, height-10);
  stroke(150);
  strokeWeight(1);
  for (int i=1; i<6; i++) {
    line(i*width/5, 0, 0, i*width/5, width, 0);
    line(        0, i*width/5, 0, width, i*width/5, 0);
  }

  lights();
  noStroke();
  fill(255, 0, 0);
  sphereDetail(10);
 
  for (int i=0; i < pointList.size(); i++) {
    PVector V = pointList.get(i);
    PVector W = new PVector(0.0, 0.0, 0.0);
    W.x = map(V.x, minX-50, range+50, 0, width);
    W.y = map(V.y, minY-50, range+50, 0, -width);
    W.z = map(V.z, minZ-50, range+50, 0, width);
    pushMatrix();
    translate(W.x, W.y, W.z);
    if (i == a){
      fill(0,100,200);
      sphere(8);
      fill(255, 0, 0);
    }
    else {
      sphere(4);
    }
    popMatrix();
  }
}

void importTextFile() {   
  String[] strLines = loadStrings("positions.txt"); // the name and extension of the file to import!
  for (int i = 0; i < strLines.length; ++i) {
    String[] arrTokens = split(strLines[i], ',');       // use the split array with character to isolate each component
    float xx = float(arrTokens[0]);                     // cast string value to a float values!
    float yy = float(arrTokens[2]);                     // cast string value to a float values!
    float zz = float(arrTokens[1]);                     // cast string value to a float values!
    pointList.add( new PVector(xx, yy, zz) );             // add values to a new array slot
  }
}

void keyPressed(){
  a++;
  if (a == pointList.size()){
    a = 0;
  }
}

