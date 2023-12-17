abstract class Vehicle {
  char[] regno;
  public Vehicle(char[] regno) {
    this.regno = regno;
  }
}

class PVehicle extends Vehicle{
  final int maxCapacity;
  public PVehicle(char[] regno, int maxCap) {
    super(regno);
    this.maxCapacity = maxCap;
  }
}
