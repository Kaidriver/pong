public class ball {
  private float x, y, dx, dy, size;
  private float speed;
  private color ballColor = color(255, 255, 255);
  public boolean start = true;
  public boolean startB = true;
  public float beginB;
  public float begin;
  public float rand;
  public float interval;
  public float intervalB; 
  public ball(float x, float y, float dx, float dy, float size, float speed) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.size = size;
    this.speed = speed;
  }
  public void move() {
     
    if (scene == 1) {
      x += dx * 1.55;
      y += dy * 1.55;
    } else {
      
     
      if (start) {
        rand = random(.6, 1.1); 
        begin = millis();
        interval = random(.75, 1.25);
        start = false;
      }
      
      float time = interval-int((millis()-begin)/1000);
      if (time <= 0) {
        System.out.println(rand);
        rand = 0;
        interval = 3;
        if (startB) {
          beginB = millis();
          startB = false;
        }
        float time2 = interval-int((millis()-beginB)/1000);
        if (time2 <= 0) {
          start = true;
          startB = true;
        }
      }
      
      x += dx * (speed + rand);
      y += dy * (speed + rand);
    }
  }
  public void display() {
    fill(this.ballColor);
    ellipse(x, y, size, size);
  }
  public void collisions() {
    if(y + (size/2) > height || y-(size/2) < 0) {
       playSound(2);
       
      dy*= -1;
    }
    if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y - player1.h/2 && y - size/2 < player1.y - player1.h/8*3)) { 
      if (dx < 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -12;
      } else {
         dy = 12;
      }  
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y - player1.h/8*3 && y - size/2 < player1.y - player1.h/8*2)) {  
      if (dx < 0) {
        dx*= -1;
      }
     if (dy < 0) {
         dy = -8;
      } else {
         dy = 8;
      } 
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y - player1.h/8*2 && y - size/2 < player1.y - player1.h/8)) {
      if (dx < 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -4;
      } else {
         dy = 4;
      }
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y - player1.h/8 && y - size/2 < player1.y + player1.h/8)) {
      if (dx < 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -1;
      } else {
         dy = 1;
      }  
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y + player1.h/8 && y - size/2 < player1.y + player1.h/8*2)) {
      if (dx < 0) {
        dx*= -1;
      }
     if (dy < 0) {
         dy = -4;
      } else {
         dy = 4;
      }   
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y + player1.h/8*2 && y - size/2 < player1.y + player1.h/8*3)) {
      if (dx < 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -8;
      } else {
         dy = 8;
      } 
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y + player1.h/8*3 && y - size/2 < player1.y + player1.h/2)) {
      if (dx < 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -12;
      } else {
         dy = 12;
      }   
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } 
    if (x + (size/2) >= player2.x-player2.w/2 &&  x <= player2.x + player2.w/2 && (y + size/2 > player2.y - player2.h/2 && y - size/2 < player2.y - player2.h/8*3)) {
      if (dx > 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -12;
      } else {
         dy = 12;
      }
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x + (size/2) >= player2.x-player2.w/2 &&  x <= player2.x + player2.w/2 && (y + size/2 > player2.y - player2.h/8*3 && y - size/2 < player2.y - player2.h/8*2)) {
      if (dx > 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -8;
      } else {
         dy = 8;
      }  
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x + (size/2) >= player2.x-player2.w/2 &&  x <= player2.x + player2.w/2 && (y + size/2 > player2.y - player2.h/8 && y - size/2 < player2.y + player2.h/8)) {
      if (dx > 0) {
        dx*= -1;
      }
    
      if (dy < 0) {
         dy = -4;
      } else {
         dy = 4;
      }  
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x + (size/2) >= player2.x-player2.w/2 &&  x <= player2.x + player2.w/2 && (y + size/2 > player2.y - player2.h/8 && y - size/2 < player2.y + player2.h/8)) {
      if (dx > 0) {
        dx*= -1;
      }
      if (dy < 0) {
         dy = -1;
      } else {
         dy = 1;
      }  
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x + (size/2) >= player2.x-player2.w/2 &&  x <= player2.x + player2.w/2 && (y + size/2 > player2.y + player2.h/8 && y - size/2 < player2.y + player2.h/8*2)) {
      if (dx > 0) {
        dx*= -1;
      }
    
      if (dy < 0) {
         dy = -4;
      } else {
         dy = 4;
      }  
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x + (size/2) >= player2.x-player2.w/2 &&  x <= player2.x + player2.w/2 && (y + size/2 > player2.y + player2.h/8*2 && y - size/2 < player2.y + player2.h/8*3)) {
      if (dx > 0) {
        dx*= -1;
      }
    
      if (dy < 0) {
         dy = -8;
      } else {
         dy = 8;
      }   
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    } else if (x + (size/2) >= player2.x-player2.w/2 &&  x <= player2.x + player2.w/2 && (y + size/2 > player2.y - player2.h/8*3 && y - size/2 < player2.y + player2.h/2)) {
      if (dx > 0) {
        dx*= -1;
      }
    
     if (dy < 0) {
         dy = -12;
      } else {
         dy = 12;
      }  
      bounced = true;
       playSound(1);
      speed *= speedChange;
      soloscore += 1;
    }
  }
  public void win () {

      if (x + size/2 < 0) {  
          p2score += 1;
          reset();
          int prob = PApplet.parseInt(random(2));
          if (prob == 0) {
           dx *= -1;
          } 
        
      } else if (x - size/2 > width){        
          p1score += 1;
          reset();
          int prob = PApplet.parseInt(random(2));
          if (prob == 0) {
            dx *= -1;
          } 
        
      }
      if (p1score == scorelimit || p2score == scorelimit) {
        scene = 4;
      }
    
  }
  public void gameover() {
    if (x +(size/2) < 0 || x - (size/2) > displayWidth) {
      if (scene == 1) {
        x = displayWidth/2;
        y = displayHeight/2;
      } else if (balls.size() > 1) {
        balls.remove(this);
      }
       else {
        scene = 10;
      }
        
    }
    if (soloscore > highscore) {
      highscore = soloscore;
    }
  }
   
}
