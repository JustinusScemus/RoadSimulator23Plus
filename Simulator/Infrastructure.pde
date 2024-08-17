abstract static class Infrastructure {
  public int getMagicNumber() {return 0;}
  public int getDenominator() {return 1000;}
  List <Point> polygon;
}

abstract class Residential extends Infrastructure {
  int population;
  protected Residential(int population) {this.population = population;}
}

class House extends Residential {
  @Override
  int getMagicNumber() {return 1020;}
  @Override
  int getDenominator() {return 1050;}
  public House(int population) {super(population);}
}

class Village extends Residential {
  @Override int getMagicNumber() {return 2;}
  @Override int getDenominator() {return 500;}
  public Village(int population) {super(population);}
}

class ResTower extends Residential {
  @Override int getMagicNumber() {return 35;}
  @Override int getDenominator() {return 100;}
  public ResTower(int population) {super(population);}
}

static class CityMap {
  private class RegisTree { //Tree
    Point point;
    RegisTree left;
    RegisTree right;
  }
  private RegisTree x_registree, y_registree;
}
