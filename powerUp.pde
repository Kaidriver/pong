public class powerUp {

  private float x, y;
  private float w = 64;
  private float h = 64;
  private int type;
  
  public powerUp( float x, float y, int type) {
    this.x = x;
    this.y = y;
    
    this.type = type;
  }

  public void display () {
    if (type == 1) {
      image(slowdown, x, y);
     
    } else if (type == 2) {
     
      image(addBall, x, y);
    } else if (type == 3) {
      
      image(removeBall, x, y);
    } else if (type == 4) {
     
      image(expand, x, y);
    } else if (type == 5) {
     
      image(shrink, x, y);
    }
  }

  public boolean collisions () {
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      float testX = ballz.x;
      float testY = ballz.y;
      if (ballz.x < x) {
        testX = x;
      } else if (ballz.x > x+w) {
        testX = x+w;
      }
      if (ballz.y < y) {
        testY = y;
      } else if (ballz.y > y+h) {
        testY = y+h;
      }
      float distX = ballz.x - testX;
      float distY = ballz.y - testY;
      float distance = sqrt((distX*distX) + (distY*distY));
      
      //float distance = dist(ballz.x, ballz.y, x, y);
      //distance <  abs(ballz.size/2 + w/2)
      if (distance <= ballz.size/2) {
        //ballz.x - ballz.size/2 < x + (w/2) && ballz.x + ballz.size/2 > x - (w/2) && ballz.y - ballz.size/2 < y + (h/2) && ballz.y + ballz.size/2 > y - (h/2)
        fill(255);
        if (type == 1) {
          timer = true; 
          startTime = true; 
          currentspd = ballz.speed;
          ballz.speed *= .5; 
        }
          
        else if (type == 2) {
          ball bal  = balls.get(0);
          balls.add(new ball(x, y, -bal.dx, -bal.dy, bal.size, bal.speed/2));
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
