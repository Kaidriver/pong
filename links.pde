public class links {
  private float x, y, w, h, type;
  public links( float x, float y, float w, float h, int type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }
  public void display () {
   imageMode(CENTER);
    if (type == 1) {
      fill(255);
      image(rateImg, x, y, w, h);
    } else if (type == 2) {
      fill(255);
      image(shareImg, x, y, w, h);
    }  
  }
}
