import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class pong extends PApplet {

ball ball = new ball(640, 360, 3, 4, 50);
platform player1 = new platform(30, 500, 20, 100);
platform player2 = new platform(1250, 500, 20, 100);
public void setup() {
  
}
public void draw() {
  background(0);
  ball.display();
  ball.move();
  player1.display();
  player2.display();

  if(ball.y + (ball.size/2) > height || ball.y-(ball.size/2) < 0) {
    ball.dy*= -1;
  }
  if (ball.x + (ball.size/2) > player2.x) {
    ball.dx*= -1;
  }
}
public void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && player2.collisionB() == false) {
      player2.y -= 10;

    }
    else if (keyCode == DOWN && player2.collisionTop() == false) {
      player2.y += 10;
    }
    else if (key == 'w') {
      player1.y -= 10;

    }
    else if (key == 's') {
      player1.y += 10;
    }


  }
}
public class ball {
  private int x, y, dx, dy, size;
  private int ballColor = color(255, 255, 255);
  public ball(int x, int y, int dx, int dy, int size) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.size = size;
  }
  public void move() {
    x += dx;
    y += dy;
  }
  public void display() {
    fill(this.ballColor);
    ellipse(x, y, size, size);
  }

}
public class platform {
   private int x, y, w, h;
   private int platColor = color(255,255,255);
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
     if (y + (h) > height) {
       return true;
     } else {
       return false;
     }
   }
   public boolean collisionB() {
     if (y + (h/2) < 0) {
       return true;
     } else {
       return false;
     }
   }

}
  public void settings() {  size(1280, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
