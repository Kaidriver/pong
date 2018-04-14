
ball ball = new ball(640, 360, 8, 0, 25,1);
ball menub = new ball(600, 600, 20, 3, 25, 1);
platform player1 = new platform(10, displayHeight/2, 20, 200);
platform player2 = new platform(displayWidth-20, displayHeight/2, 20, 200);
boolean [] keys = new boolean[128]; 
int p1score = 0;
int p2score = 0;
int soloscore = 0;
float button1x = 575;
float button1y = 500;
float button2x = 1225;
float button2y = 500;
float button3x = 880;
float button3y = 750;
int button1w = 550;
int button1h = 150;
int button2w = 550;
int button2h = 150;
int button3w = 550;
int button3h = 150;
float arrow1x = 1250;
float arrow1y = 530;
int arrow1w = 75;
int arrow1h = 75;
float arrow2x = 1350;
float arrow2y = 530;
int arrow2w = 75;
int arrow2h = 75;
int scorelimit = 5;
float speedChange = 1.1;
 
int scene = 1;
public void setup() {
  orientation(LANDSCAPE);
  size(displayWidth, displayHeight);
  rectMode(CENTER);
  textSize(48);
  background(0);
  PFont font = loadFont("ShowcardGothic-Reg-48.vlw");
  textFont(font);
  
}
public void draw() {
  if (scene == 1) {
    reset();
    menu();
    if (mouseX < button1x + (button1w/2) && mouseX > button1x - (button1w/2) && mouseY < button1y + (button1h/2) && mouseY > button1y - (button1h/2)) {
      scene = 2;
    }
    else if (mouseX < button2x + (button2w/2) && mouseX > button2x - (button2w/2) && mouseY < button2y + (button2h/2) && mouseY > button2y - (button2h/2)) {
      scene = 3;
    }
  }
  else if (scene == 2) {
      select();
  } else if (scene == 6) {
    background(0);
    text(p1score, displayWidth/10, 30);
    text(p2score, displayWidth/10*9, 30);
    ball.display();
    player1.display();
    player2.display();
     
    if (mouseX> displayWidth/2) {
        player2.x = mouseX;
        player2.y = mouseY;
  
    }
    aiMovement();
    platBoundary();
    collisions();
    ball.move();
    win();
  }
  else if (scene == 3) {
    background(0);
    text(soloscore, displayWidth/2, 30);
 
    ball.display();
    player1.display();
    player2.display();
     
    if (mouseX> displayWidth/2) {
        player2.x = mouseX;
        player2.y = mouseY;
        player1.x = mouseX;
        player1.y = mouseY;
    }
    platBoundary();
    collisions();
    ball.move();
    gameOver();
  } else if (scene == 0) {
    background(0);
    textSize(60);
    text("GAMEOVER!", displayWidth/2, displayHeight/2*.5);
    text("YOUR SCORE: " + soloscore, displayWidth/2, displayHeight/2);
    fill(0);
    stroke(255);
    rect(button3x, button3y, button3w, button3h);
    fill(255);
    textSize(48);
    text("Main Menu", button3x, button3y);
    if (mouseX < button3x + (button3w/2) && mouseX > button3x - (button3w/2) && mouseY < button3y + (button3h/2) && mouseY > button3y - (button3h/2)) {
      scene = 1;
    }
  } else if (scene == 4) {
    background(0);
    textSize(60);
    if (p1score > p2score) {
      text("YOU LOST!", displayWidth/2, displayHeight/2*.5);
    } else  {
      text("YOUR WON!", displayWidth/2, displayHeight/2);
    }
    fill(0);
    stroke(255);
    rect(button3x, button3y, button3w, button3h);
    fill(255);
    textSize(48);
    text("Main Menu", button3x, button3y);
    if (mouseX < button3x + (button3w/2) && mouseX > button3x - (button3w/2) && mouseY < button3y + (button3h/2) && mouseY > button3y - (button3h/2)) {
      scene = 1;
    }
  }
}
public void win () {
  if (ball.x < 0) {
    p2score += 1;
    reset();
    int prob = PApplet.parseInt(random(2));
    if (prob == 0) {
     ball.dx *= -1;
    } 
    delay(500);
  } else if (ball.x > width){
    p1score += 1;
    reset();
    int prob = PApplet.parseInt(random(2));
    if (prob == 0) {
      ball.dx *= -1;
    } 
    delay(500);
  }
  if (p1score == scorelimit || p2score == scorelimit) {
    scene = 4;
  }
}
public void menu() {
  background(0);
  menub.display();
  menub.move();
 
  if(menub.y + (menub.size/2) > height || menub.y-(menub.size/2) < 0) {
     menub.dy*= -1;
   } else if (menub.x + (menub.size/2) > width || menub.x-(menub.size/2) < 0) {
     menub.dx*= -1;
   }
  textAlign(CENTER);
  textSize(128);
  text("PONG", displayWidth/2, displayHeight/2*.5f);
  fill(0);
  stroke(255);
  rect(button1x, button1y, button1w, button1h);
  fill(255);
  textSize(48);
  text("Play against ai", button1x, button1y);
  fill(0);
  stroke(255);
  rect(button2x, button2y, button2w, button2h);
  fill(255);
  textSize(48);
  text("Play solo", button2x, button2y);

}
public void gameOver() {
  if (ball.x +(ball.size/2) < 0 || ball.x - (ball.size/2) > displayWidth) {
    scene = 0;
  }
}
public void reset() {
  ball.x = 640;
  ball.y = int(random(20, displayHeight-20));
  ball.dx = int(random(8,12));
  ball.dy = int(random(-2,2));
  ball.speed = 1;
  speedChange = 1.1;
  player1.y = displayHeight/2;
  player2.y = displayHeight/2;
  soloscore = 0;
  scorelimit = 5;
  if (scene == 1) {
    p1score = 0;
    p2score = 0;
  }
}
public void collisions() {
   if(ball.y + (ball.size/2) > height || ball.y-(ball.size/2) < 0) {
      ball.dy*= -1;
    }
    if (ball.x - ball.size/2 <= player1.x + player1.w/2 && ball.x - ball.size/2 >= player1.x - player1.w/2 && (ball.y + ball.size/2 > player1.y - player1.h/2 && ball.y - ball.size/2 < player1.y - player1.h/8*3)) { 
      if (ball.dx < 0) {
        ball.dx*= -1;
      }
      if (ball.dy < 0) {
         ball.dy = -12;
      } else {
         ball.dy = 12;
      }  
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x - ball.size/2 <= player1.x + player1.w/2 && ball.x - ball.size/2 >= player1.x - player1.w/2 && (ball.y + ball.size/2 > player1.y - player1.h/8*3 && ball.y - ball.size/2 < player1.y - player1.h/8*2)) {  
      if (ball.dx < 0) {
        ball.dx*= -1;
      }
     if (ball.dy < 0) {
         ball.dy = -8;
      } else {
         ball.dy = 8;
      } 
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x - ball.size/2 <= player1.x + player1.w/2 && ball.x - ball.size/2 >= player1.x - player1.w/2 && (ball.y + ball.size/2 > player1.y - player1.h/8*2 && ball.y - ball.size/2 < player1.y - player1.h/8)) {
      if (ball.dx < 0) {
        ball.dx*= -1;
      }
      if (ball.dy < 0) {
         ball.dy = -4;
      } else {
         ball.dy = 4;
      }
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x - ball.size/2 <= player1.x + player1.w/2 && ball.x - ball.size/2 >= player1.x - player1.w/2 && (ball.y + ball.size/2 > player1.y - player1.h/8 && ball.y - ball.size/2 < player1.y + player1.h/8)) {
      if (ball.dx < 0) {
        ball.dx*= -1;
      }
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x - ball.size/2 <= player1.x + player1.w/2 && ball.x - ball.size/2 >= player1.x - player1.w/2 && (ball.y + ball.size/2 > player1.y + player1.h/8 && ball.y - ball.size/2 < player1.y + player1.h/8*2)) {
      if (ball.dx < 0) {
        ball.dx*= -1;
      }
     if (ball.dy < 0) {
         ball.dy = -4;
      } else {
         ball.dy = 4;
      }   
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x - ball.size/2 <= player1.x + player1.w/2 && ball.x - ball.size/2 >= player1.x - player1.w/2 && (ball.y + ball.size/2 > player1.y + player1.h/8*2 && ball.y - ball.size/2 < player1.y + player1.h/8*3)) {
      if (ball.dx < 0) {
        ball.dx*= -1;
      }
      if (ball.dy < 0) {
         ball.dy = -8;
      } else {
         ball.dy = 8;
      } 
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x - ball.size/2 <= player1.x + player1.w/2 && ball.x - ball.size/2 >= player1.x - player1.w/2 && (ball.y + ball.size/2 > player1.y + player1.h/8*3 && ball.y - ball.size/2 < player1.y + player1.h/2)) {
      if (ball.dx < 0) {
        ball.dx*= -1;
      }
      if (ball.dy < 0) {
         ball.dy = -12;
      } else {
         ball.dy = 12;
      }   
      ball.speed *= speedChange;
      soloscore += 1;
    } 
    if (ball.x + (ball.size/2) >= player2.x-player2.w/2 &&  ball.x <= player2.x + player2.w/2 && (ball.y + ball.size/2 > player2.y - player2.h/2 && ball.y - ball.size/2 < player2.y - player2.h/8*3)) {
      if (ball.dx > 0) {
        ball.dx*= -1;
      }
      if (ball.dy < 0) {
         ball.dy = -12;
      } else {
         ball.dy = 12;
      }  
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x + (ball.size/2) >= player2.x-player2.w/2 &&  ball.x <= player2.x + player2.w/2 && (ball.y + ball.size/2 > player2.y - player2.h/8*3 && ball.y - ball.size/2 < player2.y - player2.h/8*2)) {
      if (ball.dx > 0) {
        ball.dx*= -1;
      }
      if (ball.dy < 0) {
         ball.dy = -8;
      } else {
         ball.dy = 8;
      }  
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x + (ball.size/2) >= player2.x-player2.w/2 &&  ball.x <= player2.x + player2.w/2 && (ball.y + ball.size/2 > player2.y - player2.h/8 && ball.y - ball.size/2 < player2.y + player2.h/8)) {
      if (ball.dx > 0) {
        ball.dx*= -1;
      }
    
      if (ball.dy < 0) {
         ball.dy = -4;
      } else {
         ball.dy = 4;
      }  
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x + (ball.size/2) >= player2.x-player2.w/2 &&  ball.x <= player2.x + player2.w/2 && (ball.y + ball.size/2 > player2.y - player2.h/8 && ball.y - ball.size/2 < player2.y + player2.h/8)) {
      if (ball.dx > 0) {
        ball.dx*= -1;
      }
      if (ball.dy < 0) {
         ball.dy = -1;
      } else {
         ball.dy = 1;
      }  
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x + (ball.size/2) >= player2.x-player2.w/2 &&  ball.x <= player2.x + player2.w/2 && (ball.y + ball.size/2 > player2.y + player2.h/8 && ball.y - ball.size/2 < player2.y + player2.h/8*2)) {
      if (ball.dx > 0) {
        ball.dx*= -1;
      }
    
      if (ball.dy < 0) {
         ball.dy = -4;
      } else {
         ball.dy = 4;
      }    
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x + (ball.size/2) >= player2.x-player2.w/2 &&  ball.x <= player2.x + player2.w/2 && (ball.y + ball.size/2 > player2.y + player2.h/8*2 && ball.y - ball.size/2 < player2.y + player2.h/8*3)) {
      if (ball.dx > 0) {
        ball.dx*= -1;
      }
    
      if (ball.dy < 0) {
         ball.dy = -8;
      } else {
         ball.dy = 8;
      }    
      ball.speed *= speedChange;
      soloscore += 1;
    } else if (ball.x + (ball.size/2) >= player2.x-player2.w/2 &&  ball.x <= player2.x + player2.w/2 && (ball.y + ball.size/2 > player2.y - player2.h/8*3 && ball.y - ball.size/2 < player2.y + player2.h/2)) {
      if (ball.dx > 0) {
        ball.dx*= -1;
      }
    
     if (ball.dy < 0) {
         ball.dy = -12;
      } else {
         ball.dy = 12;
      }   
      ball.speed *= speedChange;
      soloscore += 1;
    }
     
  
}
public void aiMovement() {
  if (player1.y > ball.y) {
      player1.y -= 10;
  } else if (player1.y < ball.y){
      player1.y += 10;
  }
}
public void platBoundary() {
  if (player1.x < 10 || player1.x > 10) {
      player1.x = 10;
    }
    if (player2.x < displayWidth-20 || player2.x > displayWidth-20) {
      player2.x = displayWidth-20;
    }
}
void select() {
  background(0);
  textAlign(CENTER);
  fill(255);
  text("Select scrore limit: " + scorelimit, displayWidth/2, displayHeight/2);
  fill(0);
  stroke(255);
  rect(arrow1x, arrow1y, arrow1h, arrow1w);
  fill(255);
  triangle(arrow1x-arrow1w/2, arrow1y, arrow1x+arrow1w/2, arrow1y-arrow1h/2, arrow1x+arrow1w/2, arrow1y+arrow1h/2);
  fill(0);
  stroke(255);
  rect(arrow2x, arrow2y, arrow2h, arrow2w);
  fill(255);
  triangle(arrow2x+arrow2w/2, arrow2y, arrow2x-arrow2w/2, arrow2y-arrow2h/2, arrow2x-arrow2w/2, arrow2y+arrow2h/2);
  fill(0);
  stroke(255);
  rect(button3x, button3y, button3w, button3h);
  fill(255);
  textSize(48);
  text("Play", button3x, button3y);
  if (mouseX < button3x + (button3w/2) && mouseX > button3x - (button3w/2) && mouseY < button3y + (button3h/2) && mouseY > button3y - (button3h/2)) {
      scene = 6;
  }
}
void mousePressed() {
 
     if (mouseX < arrow1x + (arrow1w/2) && mouseX > arrow1x - (arrow1w/2) && mouseY < arrow1y + (arrow1h/2) && mouseY > arrow1y - (arrow1h/2)) {
         if (scorelimit > 0) {
            scorelimit -= 1; 
         }
      }
      else if (mouseX < arrow2x + (arrow2w/2) && mouseX > arrow2x - (arrow2w/2) && mouseY < arrow2y + (arrow2h/2) && mouseY > arrow2y - (arrow2h/2)) {
        scorelimit += 1;    
      }  
 
 
}
  
