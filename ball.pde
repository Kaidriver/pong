public class ball {
  private int x, y, dx, dy, size;
  private float speed;
  private color ballColor = color(255, 255, 255);
  public ball(int x, int y, int dx, int dy, int size, float speed) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.size = size;
    this.speed = speed;
  }
  public void move() {
    if (scene == 3) {
      x += dx * ball.speed;
      y += dy * ball.speed;
    } else {
      x += dx;
      y += dy;
    }
     
  }
  public void display() {
    fill(this.ballColor);
    ellipse(x, y, size, size);
  }

}
