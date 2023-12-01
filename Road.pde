class Point{
  float x, y, z;
}
import java.util.List;
class Road {
  String name;
  List<Point> points;
  public Road(Point p1, Point p2, String name) {
    points.add(p1);
    points.add(p2);
    this.name = name;
    println("Road constructed with name: " + name);
  }
  
}
