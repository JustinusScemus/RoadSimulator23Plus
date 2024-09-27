class Point{
  float x, y, z;
  public Point(float x, float y) {
    this.x = x; this.y = y; this.z = 0f;
  }
  public Point(float x, float y, float z) {
    this.x = x; this.y = y; this.z = z;
  }
  public PVector to(Point other) {
    return new PVector(other.x - this.x, other.y - this.y, other.z - this.z);
  }
  Road join(Road a, Road b) {return a;}
}
float three_point(Point a, Point b, Point c) {
  //"cross vector" of (b-a) and (c-b)
  float x1 = b.x - a.x; float y1 = b.y - a.y;
  float x2 = c.x - b.x; float y2 = c.y - b.y;
  return (x1 * y2 - x2 - y1);
}

import java.util.List;
class Road {
  String name;
  List<Point> points = new ArrayList<Point>();
  public Road(Point p1, Point p2, String name) {
    points.add(p1);
    points.add(p2);
    this.name = name;
    println("Road constructed with name: " + name);
  }
  Point intersect(Road other) {
    //final ListIterator<Point> pts1 = this.points.listIterator(1); final ListIterator<Point> pts2 = other.points.listIterator(1);
    //do {
    //  Point a = pts1.previous(); //<>//
    //  pts1.next(); Point b = pts1.next();
    //  float f1 = three_point(a, b, pts2.previous());
    //  pts2.next(); float f2 = three_point(a, b, pts2.next());
    //} while (pts1.hasNext() && pts2.hasNext());
    
    //for (int i = 0; i < this.points.size() -1; i++) {
    //  float m1 = this.points.get(i).y;
    //  for (int j = 0; j < other.points.size() -1; j++) {
         
    //  }
    //}
    return null;
  }
  void splitmiddle(Random rnd) {
    float lerp_t = rnd.nextFloat();
    int splitsegment = rnd.nextInt(this.points.size());
    /*points.add()*/ /*lerp(,, lerp_t), lerp(,, lerp_t), lerp(,, lerp_t)*/; //TODO
  }
}
