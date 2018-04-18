public class powerUp {
  
   private float x, y, w, h;
<<<<<<< HEAD
   private int type;
   private color platColor = color(255,255,255);
   public powerUp(float x, float y, float w, float h, int type) {
=======
   
   public powerUp(float x, float y, float w, float h) {
>>>>>>> 12b464fd519d1f3c33c380bbb42ab17745f44e99
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
   }
   
   public void display () {
<<<<<<< HEAD
     fill(this.platColor);
     if (type == 1) {
       image(slowdown, x, y, w, h);
     } else if (type == 2) {
       fill(255);
       rect(x, y, w, h);
     }
     
=======
     fill(color(255,255,255));
     image(slowdown, x, y, w, h);
>>>>>>> 12b464fd519d1f3c33c380bbb42ab17745f44e99
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
