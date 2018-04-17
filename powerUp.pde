public class powerUp {
   private float x, y, w, h;
   private color platColor = color(255,255,255);
   public powerUp(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;

    this.w = w;
    this.h = h;
   }
   public void display () {
     fill(this.platColor);
     rect(x, y, w, h);
   }
   public boolean collisions () {
     if (x == ball.x && y == ball.y) {
       fill(255);
       text("YESSSSSSSSS", 800, 800);
       ball.dx *= 0;  
       ball.dy *= 0;
       return true;
     } else {
       return false;
     }
   }

}
