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
    RegisTree (Point p) {this.point = p;}
    void add(Point p, char direction) {
      boolean left; switch (direction) {
        case 'x': left = p.x < this.point.x; break;
        case 'y': left = p.y < this.point.y; break;
        case 'z': left = p.z < this.point.z; break;
        default: left = false;
      }
      if (left) {
        if (null == this.left)
        this.left = new RegisTree(p);
        else this.left.add(p, direction);
      } else {if (null == this.right)
        this.right = new RegisTree(p);
        else this.right.add(p, direction);
      }
    }
  }
  private RegisTree x_registree, y_registree;
  void registerPoint(Point p) {
    if (null == x_registree) {
      x_registree = new RegisTree(p); y_registree = new RegisTree(p); return;
    }
    x_registree.add(p, 'x');
    y_registree.add(p, 'y');
  }
  PVector toClosest(float x, float y, float z) {
    RegisTree rx = x_registree, ry = y_registree;
    float minimumMag = sqrt(sq(rx.point.x - x) + sq(rx.point.y - y)); Point tempClosest = rx.point;
    return new PVector(tempClosest.x-x, tempClosest.y-y, z);
  }
}
