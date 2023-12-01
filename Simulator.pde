//import Array;

byte pointsSelected = 0;
Point[] temppoints;
import java.util.List;

List<Road> roads;

void setup(){
  size(1600, 900);
  background(0xcfefef);
}

void mouseClicked() {
  //println("X = ", str(mouseX), "Y = ", str(mouseY));
  if (mouseButton == LEFT) {
    stroke(0xff0000, 100);// fill(0xff1f1f, 100);
    circle(mouseX, mouseY, 5);
    temppoints[pointsSelected] = (mouseX, mouseY, 0);
    pointsSelected ++;
    if (pointsSelected >= 2) {
      roads.add(new Road())
    }
  }
}

void draw() {}
