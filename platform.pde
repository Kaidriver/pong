public class platform {
   private int x, y, w, h;
   private color platColor = color(255,255,255);
   public platform(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;

    this.w = w;
    this.h = h;
   }
   public void display () {
     fill(this.platColor);
     rect(x, y, w, h);
   }
   public boolean collisionTop() {
     if (y + (h*1.1) > height) {
       return true;
     } else {
       return false;
     }
   }
   public boolean collisionB() {
     if (y - (h/10) < 0) {
       return true;
     } else {
       return false;
     }
   }

}
