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

void setup(){
  size(1600, 900);
  background(0xcfefef);
  textAlign(CENTER); textSize(50);
  fill(0x000000);
  text("Road Simulator 2023+", 800, 100);
  clock = Clock.systemDefaultZone();
  rnd.setSeed (clock.millis());
  reg_no_abc = "AB".toCharArray();
}

void mouseClicked() {
  //println("X = ", str(mouseX), "Y = ", str(mouseY));
  if (mouseButton == LEFT) {
    stroke(0xff0000); fill(0xff1f1f);
    circle(mouseX, mouseY, 5);
    redraw();
    temppoints[pointsSelected] = new Point(mouseX, mouseY, 0);
    print("New point at ", mouseX, " and ", mouseY, '\t');
    pointsSelected ++;
    if (pointsSelected >= 2) {
      roads.add(new Road(temppoints[0], temppoints[1], "Road "+str(roads.size() + 1)));
      pointsSelected = 0;
    }
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
  
  Vehicle v = spawnVehicle(rnd, String.valueOf(reg_no_abc)+" "+str(reg_no_no));
  reg_no_no += rnd.nextInt(300) + 100;
  if (v != null) {
    vehicles.put(v.regno, v);
    println("New car, ", v.regno, " class ", v.getClass().getName());
  }
  if (reg_no_no >= 9999) {
    reg_no_no -= 9900;
    if (reg_no_abc[1] == 'Z') {
      reg_no_abc[1] = 'A';
      if (reg_no_abc[0] == 'Z') reg_no_abc[0] = 'A'; else reg_no_abc[0] += 1;
    } else reg_no_abc[1]++;
  }
}
