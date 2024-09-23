import java.util.ArrayDeque;
abstract class Vehicle {
  String regno; boolean appears;
  public Vehicle(String regno) {
    this.regno = regno;
    this.appears = false;
  }
  float map_x; float map_y; private float speed; Float angle;
  ArrayDeque<Point> destinations = new ArrayDeque<Point>();
  public void setlocation(float x, float y) {this.map_x = x; this.map_y = y; appears = true;}
  void accel(int perDrawSquared) {if (angle != null) this.speed += perDrawSquared;}
  void setDestination(Point destination) {
    destinations.add(destination);
    PVector p = new Point(this.map_x, this.map_y).to(destinations.getFirst()); //<>//
    this.setMovement(p);
  }
  void setMovement(PVector p) {
    angle = atan(p.y / p.x); //<>//
    
  }
  void move() {this.map_x += cos(angle) * speed; this.map_y += sin(angle) * speed;}
}

class PVehicle extends Vehicle{
  /* Originally intended for Private Vehicle, but then I realized that I can
  make it "Passenger" Vehicle */
  final int maxCapacity;
  public PVehicle(String regno, int maxCap) {
    super(regno);
    this.maxCapacity = maxCap;
  }
}

class Minibus extends PVehicle{
  public Minibus(String regno, int maxCap) {
    super(regno, maxCap);
  }
}

class Bus extends PVehicle{
  public Bus(String regno, int maxCap) {
    super(regno, maxCap);
  }
}
