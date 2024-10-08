CityMap cm = new CityMap();

byte pointsSelected = 0;
Point[] temppoints = new Point[2];
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.time.Clock; //For spawning cars
import java.util.Random;

List<Road> roads = new ArrayList<Road>();
Map<String, Vehicle> vehicles = new HashMap<String, Vehicle>();
List<String> unspawn = new ArrayList<String>(); //vehicles that are not yet to appear, needed for random
Clock clock; Random rnd = new Random();
char[] reg_no_abc; short reg_no_no = 100;
int viewpoint_x = 0; int viewpoint_y = 0; Boolean showVP = true; boolean started = false;
int zoom = 0;
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
}

void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  zoom -= e; //Bigger number means closer zoom
  println("Zoom happens at ", mouseX, ", ", mouseY);
}

void mouseDragged() {
  int d_x = mouseX - pmouseX;
  int d_y = mouseY - pmouseY;
  viewpoint_x += d_x;
  viewpoint_y += d_y;
}

void keyPressed() {
  if (key == 'k' || key == 'K') showVP = !showVP;
}

void mouseClicked() {
  started = true;
  if (mouseButton == LEFT) {
    PVector toClosest = cm.toClosest(mouseX - viewpoint_x, mouseY - viewpoint_y, 0);
    if (toClosest != null && toClosest.mag() < 5) {
      print("Put point");
      temppoints[pointsSelected] = cm.getClosest(mouseX - viewpoint_x, mouseY - viewpoint_y);
    } else {
    temppoints[pointsSelected] = new Point(mouseX - viewpoint_x, mouseY - viewpoint_y, 0);
    print("New point at ", mouseX, " (", mouseX - viewpoint_x, ") and ", mouseY, " (", mouseY - viewpoint_y, ")", '\t');
    } pointsSelected ++;
    if (pointsSelected >= 2) {
      roads.add(new Road(temppoints[0], temppoints[1], "Road "+str(roads.size() + 1)));
      for (Point temppoint: temppoints) cm.registerPoint(temppoint) ; //resulted in static error when CityMap was Static
      pointsSelected = 0;
      temppoints[0] = null; temppoints[1] = null;
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
  if (started) background(bg_color); else{
    fill(bg_color);stroke(bg_color);
    rect(0, 110, width, height-110);
  }
  stroke(#FF0000); fill(#FFFFFF);
  for (int i = 0; i < 2; i++) {
    if (null != temppoints[i]) circle(temppoints[i].x + viewpoint_x, temppoints[i].y + viewpoint_y, 5f);
  }
  while (ri.hasNext()){
    Road r = ri.next();
    if (rnd.nextFloat() > 0.9999) {
      Point p = r.splitmiddle(rnd);
      cm.registerPoint(p);
    }
    final ListIterator<Point> pi = r.points.listIterator();
    Point p = pi.next();
    while (pi.hasNext()) {
      Point p2 = pi.next();
      line(p.x + viewpoint_x, p.y + viewpoint_y, p2.x + viewpoint_x, p2.y + viewpoint_y);
      p = p2;
    }
  }
  if (rnd.nextFloat() > 0.9) {
    String s_reg_no = String.valueOf(reg_no_abc)+" "+str(reg_no_no);
    Vehicle v = spawnVehicle(rnd, s_reg_no);
    unspawn.add(s_reg_no);
    reg_no_no += rnd.nextInt(300) + 100;
    if (v != null) {
      vehicles.put(v.regno, v);
      //println("New car, ", v.regno, " class ", v.getClass().getName());
      //println("New car, at x: ", v.map_x, " and y: ", v.map_y );
    }
  }
  float ff = rnd.nextFloat();
  if (unspawn.size() > 0) for (int a = 0; (a + 1) < ff / 0.9 && unspawn.size() > 0;) {
    int to_spawn = rnd.nextInt(unspawn.size());
    Vehicle v = vehicles.get(unspawn.get(to_spawn));
    if (v == null) {/*print("NULLCAR");*/ a++;}
    else if (!v.appears) {
      float x = rnd.nextFloat() * width - viewpoint_x; float y = rnd.nextFloat() * height - viewpoint_y;
      v.setlocation(x, y);
      PVector closestRoadPoint = cm.toClosest(x, y, 0);
      //print("Distance: "); if (closestRoadPoint == null) println("N/A"); else println(closestRoadPoint.mag()); //nullPointer?
      if (closestRoadPoint != null && closestRoadPoint.mag() < 5) {v.setMovement(closestRoadPoint);}
      unspawn.remove(to_spawn);
      a++;
    }
    
  }
  for (Map.Entry<String, Vehicle> v : vehicles.entrySet()) if (v.getValue().appears) {
    float x = v.getValue().map_x; float y = v.getValue().map_y;
    stroke(#0000FF); fill(#7F7FFF);
    circle(x + viewpoint_x, y + viewpoint_y, 5f);
    if (v.getValue().destinations.isEmpty()) {
      Point closestRoadPoint = cm.getClosest(x, y);
      if (closestRoadPoint != null) {
        PVector movement = new Point(x,y).to(closestRoadPoint);
        if (movement.mag() < 10) {
          v.getValue().setDestination (closestRoadPoint);
        }
      }
    }
    v.getValue().move();
  }
  if (reg_no_no >= 9999) {
    reg_no_no -= 9900;
    if (reg_no_abc[1] == 'Z') {
      reg_no_abc[1] = 'A';
      if (reg_no_abc[0] == 'Z') reg_no_abc[0] = 'A'; else reg_no_abc[0] += 1;
    } else reg_no_abc[1]++;
  }
  if (showVP) {
    fill(0x000000);
    textAlign(LEFT); textSize(10);
    text("Viewpoint X: "+viewpoint_x, 10, 200);
    text("Viewpoint Y: "+viewpoint_y, 10, 220);
    text("Zoom level: " + zoom, 10, 240);
  }
}
