import java.util.Queue;
abstract class Vehicle {
  String regno; boolean appears;
  public Vehicle(String regno) {
    this.regno = regno;
    this.appears = false;
  }
  float map_x; float map_y; float speed; float angle;
  Queue<Point> destinations ;
  public void setlocation(float x, float y) {this.map_x = x; this.map_y = y; appears = true;}
  void accel(int perDrawSquared) {speed += perDrawSquared;}
  void setDestination(Point destination) {}
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
