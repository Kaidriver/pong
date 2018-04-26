public class powerUp {
  
   private float x, y, w, h;
 
   private int type;
   private color platColor = color(255,255,255);
   public powerUp( float x,float y, float w, float h, int type) {
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
       image(addBall, x, y, w, h);
     } else if (type == 3) {
       fill(255);
       image(removeBall, x, y, w, h);
     } else if (type == 4) {
       fill(255);
       image(expand, x, y, w, h);
     } else if (type == 5) {
       fill(125);
       image(shrink, x, y, w, h);
     }
 
   }
   
   public boolean collisions () {
     for (int i = 0; i < balls.size(); i++) {
       ball ballz = balls.get(i);
        if (ballz.x - ballz.size/2 < x + (w/2) && ballz.x + ballz.size/2 > x - (w/2) && ballz.y - ballz.size/2 < y + (h/2) && ballz.y + ballz.size/2 > y - (h/2)) {
           
           fill(255);
           if (type == 1) {
             ballz.speed *= .5;  
             ballz.speed *= .5;
           } else if (type == 2) {
             balls.add(new ball(x, y, 8, 3, 25,1));
           } else if (type == 3) {
             if (balls.size() > 1) {
               balls.remove(balls.size()-1);
             }
           } else if (type == 4) {
             player1.h *= 1.33;
             player2.h *= 1.33;
           } else if (type == 5) {
             player1.h *= .66;
             player2.h *= .66;
           }
           
           return true;
        }  
       
     }
     return false;
   }
}
