class Point{
  float x, y, z;
  public Point(float x, float y) {
    this.x = x; this.y = y; this.z = 0f;
  }
  public Point(float x, float y, float z) {
    this.x = x; this.y = y; this.z = z;
  }
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
  
}
