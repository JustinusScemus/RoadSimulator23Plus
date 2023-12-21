abstract class Vehicle {
  char[] regno;
  public Vehicle(char[] regno) {
    this.regno = regno;
  }
}

class PVehicle extends Vehicle{
  /* Originally intended for Private Vehicle, but then I realized that I can
  make it "Passenger" Vehicle */
  final int maxCapacity;
  public PVehicle(char[] regno, int maxCap) {
    super(regno);
    this.maxCapacity = maxCap;
  }
}

class Minibus extends PVehicle{
  public Minibus(char[] regno, int maxCap) {
    super(regno, maxCap);
  }
}
