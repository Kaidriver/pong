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
      x += dx * speed;
      y += dy * speed;
    } else {
      x += dx;
      y += dy;
    }
     
  }
  public void display() {
    fill(this.ballColor);
    ellipse(x, y, size, size);
  }
  public void collisions() {
    if(y + (size/2) > height || y-(size/2) < 0) {
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
      speed *= speedChange;
      soloscore += 1;
    } else if (x - size/2 <= player1.x + player1.w/2 && x - size/2 >= player1.x - player1.w/2 && (y + size/2 > player1.y - player1.h/8 && y - size/2 < player1.y + player1.h/8)) {
      if (dx < 0) {
        dx*= -1;
      }
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
      speed *= speedChange;
      soloscore += 1;
    }
  }
   
}
