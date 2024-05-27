//import Array;

byte pointsSelected = 0;
Point[] temppoints = new Point[2];
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.time.Clock; //For spawning cars
import java.util.Random;

List<Road> roads = new ArrayList<Road>();
Map<String, Vehicle> vehicles = new HashMap<String, Vehicle>();
Clock clock; Random rnd = new Random();
char[] reg_no_abc; short reg_no_no = 100;
int viewpoint_x = 0; int viewpoint_y = 0;
final color bg_color = 0xffcfefef;

void setup(){
  size(1600, 900);
  background(bg_color);
  textAlign(CENTER); textSize(50);
  fill(0x000000);
  text("Road Simulator 2023+", 800, 100);
  clock = Clock.systemDefaultZone();
  rnd.setSeed (clock.millis());
  reg_no_abc = "AB".toCharArray();
  noLoop();
}

void mouseDragged() {
  int d_x = mouseX - pmouseX;
  int d_y = mouseY - pmouseY;
  viewpoint_x += d_x;
  viewpoint_y += d_y;
  redraw();
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    temppoints[pointsSelected] = new Point(mouseX - viewpoint_x, mouseY - viewpoint_y, 0);
    print("New point at ", mouseX, " (", mouseX - viewpoint_x, ") and ", mouseY, " (", mouseY - viewpoint_y, ")", '\t');
    pointsSelected ++;
    if (pointsSelected >= 2) {
      roads.add(new Road(temppoints[0], temppoints[1], "Road "+str(roads.size() + 1)));
      pointsSelected = 0;
      temppoints[0] = null; temppoints[1] = null;
    }
    redraw();
  }
}

Vehicle spawnVehicle(Random rnd, String regno) {
  /**Spawns a random vehicle
  of random type*/
  float a = rnd.nextFloat();
  if (a < 0.1) return new PVehicle(regno, Math.round(a * 30 + 4));
  if (a > 0.9) return new Bus(regno, Math.round(a * 30 + 120));
  return null;
}

void draw() {
  final ListIterator<Road> ri = roads.listIterator();
  fill(bg_color);stroke(bg_color);
  rect(0, 110, width, height-110);
  stroke(#FF0000); fill(#FFFFFF);
  for (int i = 0; i < 2; i++) {
    if (null != temppoints[i]) circle(temppoints[i].x + viewpoint_x, temppoints[i].y + viewpoint_y, 5f);
  }
  while (ri.hasNext()){
    Road r = ri.next();
    final ListIterator<Point> pi = r.points.listIterator();
    Point p = pi.next();
    while (pi.hasNext()) {
      Point p2 = pi.next();
      line(p.x + viewpoint_x, p.y + viewpoint_y, p2.x + viewpoint_x, p2.y + viewpoint_y);
    }
  }
  if (rnd.nextFloat() > 0.9) {
    Vehicle v = spawnVehicle(rnd, String.valueOf(reg_no_abc)+" "+str(reg_no_no));
    reg_no_no += rnd.nextInt(300) + 100;
    if (v != null) {
      vehicles.put(v.regno, v);
      //println("New car, ", v.regno, " class ", v.getClass().getName());
    }
  }
  if (reg_no_no >= 9999) {
    reg_no_no -= 9900;
    if (reg_no_abc[1] == 'Z') {
      reg_no_abc[1] = 'A';
      if (reg_no_abc[0] == 'Z') reg_no_abc[0] = 'A'; else reg_no_abc[0] += 1;
    } else reg_no_abc[1]++;
  }
  
  fill(0x000000);
  textAlign(LEFT); textSize(10);
  text("Viewpoint X: "+viewpoint_x, 10, 200);
  text("Viewpoint Y: "+viewpoint_y, 10, 220);
}
