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

class Industrial extends Infrastructure {}

class Commercial extends Infrastructure {}

class Recreational extends Infrastructure {}

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
    Point closest = getClosest(x,y);
    if (closest == null) return null;
    return new PVector(closest.x-x, closest.y-y, z);
  }
  Point getClosest(float x, float y) {
    RegisTree rx = x_registree, ry = y_registree; if (rx == null) return null;
    Point tempClosest = rx.point; if (tempClosest == null) return null;
    float minimumMag = sqrt(sq(tempClosest.x - x) + sq(tempClosest.y - y)), tempMag;
    do {
      tempMag = sqrt(sq(rx.point.x - x) + sq(rx.point.y - y));
      if (tempMag < minimumMag) {
        tempClosest = rx.point; minimumMag = tempMag;
      }
      RegisTree direction; if (x > rx.point.x) direction = rx.right; else direction = rx.left;
      rx = direction;
    } while (null != rx);
    while (null != ry){
      if (y > ry.point.y) ry = ry.right; else ry = ry.left;
      if (ry != null) 
      {
        tempMag = sqrt(sq(ry.point.x - x) + sq(ry.point.y - y));
        if (tempMag < minimumMag) {
          tempClosest = ry.point; minimumMag = tempMag;
        }
      }
    }
    return tempClosest;
  }
}
