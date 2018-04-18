public class powerUp {
   private float x, y, w, h;
   private int type;
   private color platColor = color(255,255,255);
   public powerUp(float x, float y, float w, float h, int type) {
    this.x = x;
    this.y = y;

    this.w = w;
    this.h = h;
    this.type = type;
   }
   public void display () {
     fill(this.platColor);
     if (type == 1) {
       image(slowdown, x, y, w, h);
     } else if (type == 2) {
       fill(255);
       rect(x, y, w, h);
     }
     
   }
   public boolean collisions () {
     for (int i = 0; i < balls.size(); i++) {
       ball ballz = balls.get(i);
        if (ballz.x < x + (w/2) && ballz.x > x - (w/2) && ballz.y < y + (h/2) && ballz.y > y - (h/2)) {
           
           fill(255);
           if (type == 1) {
             ballz.dx *= .5;  
             ballz.dy *= .5;
           } else if (type == 2) {
             balls.add(new ball(x, y, 8, 3, 25,1));
           }
           
           return true;
        }  
       
     }
     return false;
    
   }

}
