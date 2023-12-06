//import Array;

byte pointsSelected = 0;
Point[] temppoints = new Point[2];
import java.util.List;

List<Road> roads = new ArrayList<Road>();

void setup(){
  size(1600, 900);
  background(0xcfefef);
  textAlign(CENTER); textSize(50);
  text("Road Simulator 2023+", 800, 2);
}

void mouseClicked() {
  //println("X = ", str(mouseX), "Y = ", str(mouseY));
  if (mouseButton == LEFT) {
    stroke(0xff0000); fill(0xff1f1f);
    circle(mouseX, mouseY, 5);
    temppoints[pointsSelected] = new Point(mouseX, mouseY, 0);
    pointsSelected ++;
    if (pointsSelected >= 2) {
      roads.add(new Road(temppoints[0], temppoints[1], "Road 1"));
      pointsSelected = 0;
    }
  }
}

void draw() {}
