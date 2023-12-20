//import Array;

byte pointsSelected = 0;
Point[] temppoints = new Point[2];
import java.util.List;
import java.util.ListIterator;
import java.time.Clock; //For spawning cars

List<Road> roads = new ArrayList<Road>();

void setup(){
  size(1600, 900);
  background(0xcfefef);
  textAlign(CENTER); textSize(50);
  fill(0x000000);
  text("Road Simulator 2023+", 800, 100);
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

void draw() {
  final ListIterator<Road> ri = roads.listIterator();
  stroke(#FF0000);
  while (ri.hasNext()){
    Road r = ri.next();
    final ListIterator<Point> pi = r.points.listIterator();
    Point p = pi.next();
    while (pi.hasNext()) {
      Point p2 = pi.next();
      line(p.x, p.y, p2.x, p2.y);
    }
  }
}
