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
     image(slowdown, x, y, w, h);
   }
   public boolean collisions () {
     if (ball.x < x + (w/2) && ball.x > x - (w/2) && ball.y < y + (h/2) && ball.y > y - (h/2)) {
       fill(255);
       
       ball.dx *= .5;  
       ball.dy *= .5;
       return true;
     } else {
       return false;
     }
   }

}
