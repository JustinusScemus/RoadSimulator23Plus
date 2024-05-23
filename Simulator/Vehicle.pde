abstract class Vehicle {
  String regno;
  public Vehicle(String regno) {
    this.regno = regno;
  }
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
