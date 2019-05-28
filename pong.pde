import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.content.res.AssetFileDescriptor;
import android.content.Context;
import android.app.Activity;
import android.view.MotionEvent; 
import android.media.MediaPlayer;
import android.media.SoundPool;
import android.media.AudioManager;


SoundPool soundPool;
HashMap<Object, Object> soundPoolMap;
Activity act;
Context cont;
AssetFileDescriptor afd1, afd2;
int boopH, boopL;
int streamId;
ball menub;
platform player1; 
platform player2;  
PFont font;
static final String CONFIG_FILE = "save.txt";
boolean [] keys = new boolean[128]; 
ArrayList <powerUp> powerups = new ArrayList <powerUp> ();
ArrayList <ball> balls = new ArrayList <ball> ();
int p1score = 0;
int p2score = 0;
int soloscore = 0;
float button1x, button1y, button2x, button2y, button3x, button3y, button4x, button4y, button5x, button5y;
boolean resetVal = false;
float buttonh;
float buttonw;
float arrow1x;
float arrow1y;
float arrow1w;
float arrow1h;
float arrow2x;
float arrow2y;
float arrow2w;
float arrow2h;
float arrow3x;
float arrow3y;
boolean resetPos;
float arrow4x;
float arrow4y;
float arrow5x;
float arrow5y;
float arrow6x;
float arrow6y;
float arrow7x;
float arrow7y;
float arrow8x;
float arrow8y;
float backbtnx;
float backbtny;
float backbtnw;
float backbtnh;
float pausebtnx, pausebtnx2;
float pausebtny;
float pausebtnw;
float pausebtnh;
float unpausebtnx;
float unpausebtny;
float unpausebtnw;
float unpausebtnh;
float pmenubtnx;
float pmenubtny;
float currentspd;
boolean timer;
boolean changed;
float location;
float start;
int scorelimit = 5;
int highscore = 1;
float px, py;
int crazyMode = 0;
boolean loop = true;
float speedChange = 1.0125;
int scene = 0;
int projScene;
PImage slowdown;
PImage addBall;
PImage removeBall;
PImage expand;
float [] val;
PImage shrink;
PImage [] logo;
PImage [] pups;
PImage rateImg, shareImg, line;
boolean calculate;
int prevScene;
boolean bounced;
int x = 0;
int y = 0;
float last;
int aiMode;
int pup;
links rate, share;
//Timer 
boolean start2 = true;
boolean startTime = false; 
float begin2;  
float pupTime; 
ArrayList <platform> platform1 = new ArrayList <platform> ();
ArrayList <platform> platform2 = new ArrayList <platform> ();
//PrintWriter output = createWriter("save.txt");
public void setup() {
  
  orientation(LANDSCAPE);
  frameRate(60);
  fullScreen(P2D);
  button1x = displayWidth/4*1.2;
  button1y = displayHeight/4*2;
  button2x = displayWidth/4*2.8;
  button2y = displayHeight/4*2;
  button3x = displayWidth/2;
  button3y = displayHeight/4*3;
  button4x = displayWidth/4*1.2;
  button4y = displayHeight/4*3;
  button5x = displayWidth/4*2.8;
  button5y = displayHeight/4*3; 
  buttonw = displayWidth*.286;
  buttonh = displayHeight*.139;
  arrow1x = displayWidth*.703;
  arrow1y = displayHeight*.491;
  arrow1w = displayWidth*.044;
  arrow1h = displayHeight*.074;
  arrow2x = displayWidth*.760;
  arrow2y = displayHeight*.491;
  arrow2w = displayWidth*.044;
  arrow2h = displayHeight*.074;
  arrow3x = displayWidth*.703;
  arrow3y = displayHeight/2*.57;
  arrow4x = displayWidth*.82;
  arrow4y = displayHeight/2*.57;
  arrow5x = displayWidth*.69;
  arrow5y = displayHeight*.12;
  arrow6x = displayWidth*.835;
  arrow6y = displayHeight*.12;
  arrow7x = displayWidth/2*1.12;
  arrow7y = displayHeight/2*1.47;
  arrow8x = displayWidth/2*1.35;
  arrow8y = displayHeight/2*1.47;
  backbtnx = displayWidth/10;
  backbtny = displayHeight/9;
  backbtnw = displayWidth*.044;
  backbtnh = displayHeight*.074;
  pausebtnx = displayWidth/3*2;
  pausebtnx2 = displayWidth/3;
  pausebtny = displayHeight*.085;
  pausebtnh = displayWidth*.030;
  pausebtnw = displayHeight*.011;
  unpausebtnx = displayWidth/2;
  unpausebtny = displayHeight/2;
  unpausebtnw = displayWidth*.044;
  unpausebtnh = displayHeight*.074;
  pmenubtnx = displayWidth/2;
  pmenubtny = displayHeight*.7;
  projScene = 1;
  changed = false;
  location = 0;
  pup = 0;
  menub = new ball(displayWidth*.3125, displayHeight*.556, displayWidth*.01, displayHeight*.017777, displayWidth*.013, 2);
  player1 = new platform(displayWidth*.0052, displayHeight/2, displayWidth*.05, displayHeight*.185, 0);
  player2 = new platform(displayWidth*.9896, displayHeight/2, displayWidth*.05, displayHeight*.185, 0);
  
  //Platform group 1
  for (int i = 0; i < 9; i++) {
    
    float x = 0; 
    float y = 0;
    int type = 0;
    if (i < 3) {
      x = displayWidth*.14+(i*displayWidth*.06);
      y = displayHeight/6*2;
      type = 1;
    }
    else if (i < 6) {
      x = displayWidth*.14+((i-3)*displayWidth*.06);
      y = displayHeight/6*3;
      type = 2;
    }
    else if (i < 9) {
      x = displayWidth*.14+((i-6)*displayWidth*.06);
      y = displayHeight/6*4;
      type = 3;
    }
    platform1.add(new platform(x, y,displayWidth*.05, displayHeight*.15, type));
  }
  
  //PLatform group 2
  for (int i = 0; i < 9; i++) {
    float x = 0; 
    float y = 0;
    int type = 0;
    if (i < 3) {
      x = displayWidth*.86-(i*displayWidth*.06);
      y = displayHeight/6*2;
      type = 1;
    }
    else if (i < 6) {
      x = displayWidth*.86-((i-3)*displayWidth*.06);
      y = displayHeight/6*3;
      type = 2;
    }
    else if (i < 9) {
      x = displayWidth*.86-((i-6)*displayWidth*.06);
      y = displayHeight/6*4;
      type = 3;
    }
    platform2.add(new platform(x, y,displayWidth*.05, displayHeight*.15, type));
  }
  rate = new links (displayWidth/2*.25, displayHeight/2, displayWidth*.10, displayWidth*.10, 1);
  share = new links (displayWidth/2*1.75, displayHeight/2, displayWidth*.10, displayWidth*.10, 2);
  calculate = true;
  rectMode(CENTER);
  textSize(48);
  background(0);
  font = createFont("ARCADECLASSIC.TTF", 48);
  slowdown = loadImage("slowdown2.png");
  slowdown.resize(64, 64);
  addBall = loadImage("add.png");
  addBall.resize(64, 64);
  removeBall = loadImage("removeball.png");
  removeBall.resize(64, 64);
  expand = loadImage("expand.png");
  expand.resize(64, 64);
  shrink = loadImage("shrink.png");
  shrink.resize(64, 64);
  rateImg = loadImage("rate.png");
  shareImg = loadImage("share.png");
  line = loadImage("line.png");
  line.resize(100, 1080);
  logo = new PImage[5];
  for (int i = 0; i < logo.length; i++) {
    String filename = "startScreen" + i + ".gif";
    logo[i] = loadImage(filename);
  }
  pups = new PImage[5];
  for (int i = 0; i < pups.length; i++) {
    String filename = "pup" + i + ".png";
    pups[i] = loadImage(filename);
  }
  act = this.getActivity();
  cont = act.getApplicationContext();

  // load up the files
  try {
    afd1 = cont.getAssets().openFd("boopH.wav");
    afd2 = cont.getAssets().openFd("boopL.wav");
  } 
  catch(IOException e) {
    println("error loading files:" + e);
  }

  // create the soundPool HashMap - apparently this constructor is now depracated?
  soundPool = new SoundPool(12, AudioManager.STREAM_MUSIC, 0);
  soundPoolMap = new HashMap<Object, Object>(2);
  soundPoolMap.put(boopH, soundPool.load(afd1, 1));
  soundPoolMap.put(boopL, soundPool.load(afd2, 1));
  image(logo[0], 0, 0, width, height);
  requestPermission("android.permission.READ_EXTERNAL_STORAGE");
  requestPermission("android.permission.WRITE_EXTERNAL_STORAGE");
  loadData();
  textFont(font, 32);
}
public void draw() {
  saveData();
  if (scene == 0) {
    createLogo();
  } else if (scene == 99) {
    scorelimit = 5;
    reset();
  } else if (scene == 1) {
    menu();
  } else if (scene == 2) {
    select();
  } else if (scene == 6) {

    background(0);

    text(p1score, displayWidth/10, displayHeight*.035);
    text(p2score, displayWidth/10*9, displayHeight*.035);

    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.display();
      ballz.collisions();
      ballz.move();
      ballz.win();
    }
    bkground();
    player1.display();
    player2.display();
    
    pause();
    aiMovement();
    platBoundary();
    
    if (crazyMode == 0 && changed == true) {
      powerup();
      for (int i = 0; i < powerups.size(); i++) {
        powerUp powerup = powerups.get(i);
        powerup.display();
        if (powerup.collisions()) {
          powerups.remove(i);
        }
      }
    }
  } else if (scene == 3) {
    background(0);
    text(frameRate, 200, 200);
    textSize(50);
    text(soloscore, displayWidth/3, displayHeight*.085);
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.display();
      ballz.collisions();
      ballz.move();
      ballz.gameover();
    }
    bkground();
    player1.display();
    player2.display();
    
    pause();
    player1.y = player2.y;
    platBoundary();
    if (changed == true) {
      powerup();
      for (int i = 0; i < powerups.size(); i++) {
        powerUp powerup = powerups.get(i);
        powerup.display();
        if (powerup.collisions()) {
          powerups.remove(i);
        }
      }
    }
  } else if (scene == 10) {
    
    background(0);
    textSize(60);
    text("GAMEOVER!", displayWidth/2, displayHeight/2*.5);
    text("YOUR SCORE: " + soloscore, displayWidth/2, displayHeight/2);
    text("HIGH SCORE: " + highscore, displayWidth/2, displayHeight/2*1.25);
    fill(0);
    stroke(255);
    rect(button3x, button3y, buttonw, buttonh);
    fill(255);
    textSize(48);
    text("Main Menu", button3x, button3y);
    rate.display();
    text("Rate the game!", rate.x, rate.y+displayWidth*.1);
    share.display();
    text("Follow our facebook!", share.x, share.y+displayWidth*.1);
    if (mouseX < button3x + (buttonw/2) && mouseX > button3x - (buttonw/2) && mouseY < button3y + (buttonh/2) && mouseY > button3y - (buttonh/2)) {
      projScene = 1;
      scene = 99;
    } 
 
  } else if (scene == 4) {
    background(0);
    textSize(60);
    if (scene == 3) {
      if (p1score > p2score) {
        text("YOU LOST!", displayWidth/2, displayHeight/2*.5);
      } else {
        text("YOU WON!", displayWidth/2, displayHeight/2);
      }
    } else {
      if (p1score > p2score) {
        text("Player 1 Won!", displayWidth/2, displayHeight/2*.5);
      } else {
        text("Player 2 Won!", displayWidth/2, displayHeight/2);
      }
    }

    fill(0);
    stroke(255);
    rect(button3x, button3y, buttonw, buttonh);
    fill(255);
    textSize(48);
    text("Main Menu", button3x, button3y);
    rate.display();
    text("Rate the game!", rate.x, rate.y+displayWidth*.1);
    share.display();
    text("Follow our facebook!", share.x, share.y+displayWidth*.1);
    if (mouseX < button3x + (buttonw/2) && mouseX > button3x - (buttonw/2) && mouseY < button3y + (buttonh/2) && mouseY > button3y - (buttonh/2)) {
      projScene = 1;
      scene = 99;
    }
  } else if (scene == 7) {
    select();
  } else if (scene == 8) {
    background(0);
    text(p1score, displayWidth/10, displayHeight*.035);
    text(p2score, displayWidth/10*9, displayHeight*.035);
    bkground();
    if (crazyMode != 2) {
      player1.display();
      player2.display();
    }
    else {
      for (int i = 0; i < platform1.size(); i++) {
        platform1.get(i).display();
        platform2.get(i).display();
      }
    }
    pause();
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.display();
      ballz.collisions();
      ballz.move();
      ballz.win();
    }
    if (crazyMode == 0 && changed == true) {
      powerup();
      for (int i = 0; i < powerups.size(); i++) {
        powerUp powerup = powerups.get(i);
        powerup.display();
        if (powerup.collisions()) {
          powerups.remove(i);
        }
      }
    }
    platBoundary();
  } else if (scene == 9) {
    howtoplayscreen();
  } else if (scene == 11) {
     
    background(0);
    if (prevScene == 6 || prevScene == 8) {
      text(p1score, displayWidth/10, displayHeight*.035);
      text(p2score, displayWidth/10*9, displayHeight*.035);
    } else {
      text(soloscore, displayWidth/2, displayHeight*.035);
    }
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.display();
      ballz.collisions();
      ballz.win();
    }
 
    player1.display();
    player2.display();
    unpause(prevScene);
    platBoundary();
    if (crazyMode == 0) {
      for (int i = 0; i < powerups.size(); i++) {
        powerUp powerup = powerups.get(i);
        powerup.display();
        if (powerup.collisions()) {
          powerups.remove(i);
        }
      }
    }
  }
}

public void menu() {
  background(0);
  menub.display();
  menub.move();
  menub.collisions();
  menub.gameover();
  player2.display();
  player1.display();
  aiMovement();
  platBoundary();
  textAlign(CENTER);
  textSize(128);
  text("PONG", displayWidth/2, displayHeight/2*.5f);
  text(frameRate, 200, 200);
  fill(0);
  stroke(255);
  rect(button1x, button1y, buttonw, buttonh);
  rect(button2x, button2y, buttonw, buttonh);
  rect(button4x, button4y, buttonw, buttonh);
  rect(button5x, button5y, buttonw, buttonh);
  fill(255);
  textSize(48);
  text("Play against ai", button1x, button1y);
  text("Play solo", button2x, button2y);
  text("Two Player", button4x, button4y);
  text("How to Play", button5x, button5y);
}

public void reset() {
  resetVal = true;
  resetPos = true;
  changed = false;
  balls.clear();
  
  balls.add(new ball(player2.x-player2.w*3/4, displayHeight/2, 0, 0, displayWidth*.013, 1.55));
  menub = new ball(displayWidth/2, displayHeight/2, -displayWidth*.008, 0, displayWidth*.013, 1.55);
  powerups.clear();
  speedChange = 1.025;
  calculate = true;
  player1.y = displayHeight/2;
  player2.y = displayHeight/2; 
  player1.h = displayHeight*.185;
  player2.h = displayHeight*.185;
  soloscore = 0;

  if (scene == 99) {
    p1score = 0;
    p2score = 0;
  }
  scene = projScene;
}
public void bkground() {
  for (float i = displayHeight*.055555555; i < displayHeight; i+=displayHeight*.055555555) {
    rect(displayWidth/2, i, displayWidth*.01041666666, displayWidth*.01041666666);
  }
 // image(line, displayWidth/2-displayWidth*0.01041666, 0);
}
public void aiMovement() {
  
  if (scene == 1 && calculate) {
    val = calculations();
    location = val[0];
    calculate = false;
  } else if (scene == 6) {
    val = calculations();
    location = val[0];
  }
  text(val[1], 900, 300);
  text(location, 300, 300);
  text(menub.y, 300, 600);
  text(menub.x, 1200, 300);
  text(str(calculate), 300, 900);
  text(menub.dx, 600, 900);
 
  if (player1.y > displayHeight - player1.h/2){
    player1.y = displayHeight - player1.h/2;
  }
  if (player1.y < player1.h/2) {
    player1.y = player1.h/2;
  }
if (scene == 1) {
    if (menub.dx > 0) {
      if (player2.y > location) {
        player2.y -= displayWidth*.00625;
      } 
      if (player2.y < location) {
        player2.y += displayWidth*.00625;
      }
      if (player2.y < player2.w/2) {
        player2.y += 0;
      } else if (player2.y > displayHeight  - player2.w/2) {
        player2.y += 0;
      }
    } else if (menub.dx < 0) {
      if (player1.y > location) {
        player1.y -= displayWidth*.00625;
      } 
      if (player1.y < location) {
        player1.y += displayWidth*.00625;
      }
     
      if (player1.y < player1.w/2) {
         player1.y += 0;
      } else if (player1.y > displayHeight - player1.w/2) {
          player1.y += 0;
      }
  
    }
    if (bounced) {
      calculate = true;
      bounced = false;
    }
  } else {
    if (aiMode == 1 || aiMode == 2) {
      double speed = 0;
      if (aiMode == 1) {
        speed = displayHeight*.01;
      } else {
        speed = displayHeight*.0175;
      }
      for (int i = 0; i < balls.size(); i++) {
        ball ballz = balls.get(i);
        if (ballz.dx < 0) {
          if (player1.y > ballz.y) {
            player1.y -= speed;
          } 
          if (player1.y < ballz.y) {
            player1.y += speed;
          }
        }
      }
    } else {

      for (int i = 0; i < balls.size(); i++) {
        ball ballz = balls.get(i);
        if (ballz.dx < 0) {
          if (player1.y > location) {
            player1.y -= displayWidth*.00625;
          } 
          if (player1.y < location) {
            player1.y += displayWidth*.00625;
          }
        }
              
      }
     
    }
  }
}

public float [] calculations () {
  float destination = 0;
  float bounceLocation = 0;
  ball ballz = balls.get(0);
   
    if (scene == 6) {

      for (int i = 0; i < balls.size(); i++) {
        ball closestBall = balls.get(i);
        if (closestBall.x < ballz.x && closestBall.dx < 0) {
          ballz = closestBall;
        }
      }
      if  (resetPos) {
        destination = displayHeight/2;
        resetPos = false;
      } 
      if (ballz.dx < 0) {
        if ((ballz.dy/ballz.dx)*(-ballz.x)+ballz.y < 0) {
          bounceLocation = ballz.x - (ballz.y*ballz.dx)/ballz.dy;
          destination = -(ballz.dy/ballz.dx)*(-bounceLocation);
          if ((-ballz.dy/ballz.dx)*(-bounceLocation) > displayHeight) {
            /*float temp = bounceLocation;
            bounceLocation = (-((displayHeight*ballz.dx)/-ballz.dy) + ballz.x - temp);
            destination = -(ballz.dy/ballz.dx)*(-bounceLocation)+ displayHeight;
            */
            destination = displayWidth - (displayHeight - (destination-displayHeight));
          }
        } else if ((ballz.dy/ballz.dx)*(-ballz.x)+ballz.y > displayHeight) {
          bounceLocation = ballz.x - ((displayHeight - ballz.y)*-(ballz.dx))/ballz.dy;
          destination = -(ballz.dy/ballz.dx)*(-bounceLocation)+ displayHeight;
          if (-(ballz.dy/ballz.dx)*(-bounceLocation)+displayHeight < 0) {
            /*float temp = bounceLocation;
            bounceLocation = ((-((displayHeight*ballz.dx)/ballz.dy)) + ballz.x - temp);
            destination = (-ballz.dy/ballz.dx)*(-bounceLocation);
             */
             destination = -destination;
          }
        } else {
          destination = (ballz.dy/ballz.dx)*(-ballz.x)+ (ballz.y);
        }
      }
    } else if (calculate) {
      if (menub.dx < 0) {
        if ((menub.dy/menub.dx)*(-menub.x)+menub.y < 0) {
          bounceLocation = displayWidth - (menub.y*menub.dx)/menub.dy;
          destination = -(menub.dy/menub.dx)*(-bounceLocation);
          if (-(menub.dy/menub.dx)*(-bounceLocation) > displayHeight) {
            float temp = bounceLocation;
            bounceLocation = (-((displayHeight*menub.dx))/-menub.dy) + menub.x - temp;
            destination = -(menub.dy/menub.dx)*(-bounceLocation)+ displayHeight;
          }
        } else if ((menub.dy/menub.dx)*(-menub.x)+menub.y > displayHeight) {
          bounceLocation = displayWidth - ((displayHeight - menub.y)*-(menub.dx))/menub.dy;
          destination = -(menub.dy/menub.dx)*(-bounceLocation)+ displayHeight;
          if (-(menub.dy/menub.dx)*(-bounceLocation)+displayHeight < 0) {
            float temp = bounceLocation;
            bounceLocation = ((-((displayHeight*menub.dx)/menub.dy)) + menub.x - temp);
            destination = -(menub.dy/menub.dx)*(-bounceLocation);
          }
        } else {
          destination = (menub.dy/menub.dx)*(-menub.x)+ (menub.y);
        }
      } else if (menub.dx > 0) {
        if ((menub.dy/menub.dx)*(displayWidth - menub.x)+menub.y < 0) {
          bounceLocation = -(menub.y*menub.dx)/menub.dy;
          destination = -(menub.dy/menub.dx)*(displayWidth - bounceLocation);
          if ((-menub.dy/menub.dx)*(displayWidth - bounceLocation) > displayHeight) {
            float temp = bounceLocation;
             bounceLocation = -((displayHeight)*(menub.dx/-menub.dy) - displayWidth+temp-menub.x);
             destination = -(menub.dy/menub.dx)*(displayWidth - bounceLocation)+displayHeight;
          }
        } else if ((menub.dy/menub.dx)*(displayWidth - menub.x)+menub.y > displayHeight) {
          bounceLocation = (displayHeight - menub.y)*(menub.dx/menub.dy);
          destination = -(menub.dy/menub.dx)*(displayWidth - bounceLocation)+displayHeight;
          if ((-menub.dy/menub.dx)*(displayWidth - bounceLocation) + displayHeight < 0) {
            float temp = bounceLocation;
            bounceLocation = -(((displayHeight*menub.dx)/menub.dy) + -menub.x-displayWidth+temp);
            destination = -(menub.dy/menub.dx)*(displayWidth - bounceLocation);
          }
        } else {
          destination = (menub.dy/menub.dx)*(displayWidth - menub.x)+menub.y;
        }
     }
  }
  
  float [] val = {destination, bounceLocation};
  return val;
}
public void platBoundary() {
  if (player1.x < displayWidth*.0052 || player1.x > displayWidth*.0052) {
    player1.x = displayWidth*.0052;
  }
  if (player2.x < displayWidth-displayWidth*.0104 || player2.x > displayWidth-displayWidth*.0104 ) {
    player2.x = displayWidth-displayWidth*.0104 ;
  }
  if (scene == 1) {
    if (player1.y < player1.w/2) {
       player1.y = player1.w/2;
    } else if (player1.y > displayHeight -player1.w/2) {
       player1.y = displayHeight-player1.w/2;
    } else if (player2.y < player2.w/2) {
       player2.y = player2.w/2;
    } else if (player2.y > displayHeight - player2.w/2) {
       player2.y = displayHeight-player2.w/2;
    }
  }
}

void select() {
  background(0);
  textAlign(CENTER);
  fill(255);
  text("Back", displayWidth/5.75, displayHeight/8.25);
  fill(0);
  stroke(255);
  rect(backbtnx, backbtny, backbtnw, backbtnh);
  fill(255);
  triangle(backbtnx-backbtnw/2, backbtny, backbtnx+backbtnw/2, backbtny-backbtnh/2, backbtnx+backbtnw/2, backbtny+backbtnh/2);
  fill(255);
  text("Crazy Mode", displayWidth/2, displayHeight/2*.6);
  fill(0);
  stroke(255);
  rect(arrow3x, arrow3y, arrow1h, arrow1w);
  fill(255);
  triangle(arrow3x-arrow1w/2, arrow3y, arrow3x+arrow1w/2, arrow3y-arrow1h/2, arrow3x+arrow1w/2, arrow3y+arrow1h/2);
  fill(0);
  stroke(255);
  rect(arrow4x, arrow4y, arrow2h, arrow2w);
  fill(255);
  triangle(arrow4x+arrow2w/2, arrow4y, arrow4x-arrow2w/2, arrow4y-arrow2h/2, arrow4x-arrow2w/2, arrow4y+arrow2h/2);
  if (crazyMode == 0) {
    text("Crazy", displayWidth*.763, displayHeight/2*.59);
  } else if (crazyMode == 1) {
    text("Normal", displayWidth*.763, displayHeight/2*.59);
  } else if (scene == 7 && crazyMode == 2) {
    text("Brick", displayWidth*.763, displayHeight/2*.59);
  }
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
  rect(button3x, button3y, buttonw, buttonh);
  fill(255);
  textSize(48);
  text("Play", button3x, button3y);
  if (scene == 2) {
    fill(255);
    text("Ai Difficulty:", displayWidth/2, displayHeight/2*.3);
    fill(0);
    stroke(255);
    rect(arrow5x, arrow5y, arrow1h, arrow1w);
    fill(255);
    triangle(arrow5x-arrow1w/2, arrow5y, arrow5x+arrow1w/2, arrow5y-arrow1h/2, arrow5x+arrow1w/2, arrow5y+arrow1h/2);
    fill(0);
    stroke(255);
    rect(arrow6x, arrow6y, arrow1h, arrow1w);
    fill(255);
    triangle(arrow6x+arrow2w/2, arrow6y, arrow6x-arrow2w/2, arrow6y-arrow2h/2, arrow6x-arrow2w/2, arrow6y+arrow2h/2);
    if (aiMode == 1) {
      text("Easy", displayWidth*.763, displayHeight/2*.265);
    } else if (aiMode == 2) {
      text("Medium", displayWidth*.763, displayHeight/2*.265);
    } else {
      text("Hard", displayWidth*.763, displayHeight/2*.265);
    }
  }
  if (mouseX < button3x + (buttonw/2) && mouseX > button3x - (buttonw/2) && mouseY < button3y + (buttonh/2) && mouseY > button3y - (buttonh/2)) {
    if (scene == 7) {
      projScene = 8;
      reset();
    } else {
      projScene = 6;
      reset();
    }
  } else if (mouseX < backbtnx + (backbtnw/2) && mouseX > backbtnx - (backbtnw/2) && mouseY < backbtny + (backbtnh/2) && mouseY > backbtny - (backbtnh/2)) {
    projScene = 1;
    scene = 99;
  }
}
void mousePressed() {

  if (mouseX < arrow1x + (arrow1w/2) && mouseX > arrow1x - (arrow1w/2) && mouseY < arrow1y + (arrow1h/2) && mouseY > arrow1y - (arrow1h/2)) {
    if (scorelimit > 0) {
      scorelimit -= 1;
    }
  } else if (mouseX < arrow2x + (arrow2w/2) && mouseX > arrow2x - (arrow2w/2) && mouseY < arrow2y + (arrow2h/2) && mouseY > arrow2y - (arrow2h/2)) {
    scorelimit += 1;
  } else if (mouseX < arrow3x + (arrow1w/2) && mouseX > arrow3x - (arrow1w/2) && mouseY < arrow3y + (arrow1h/2) && mouseY > arrow3y - (arrow1h/2)) {

    crazyMode--;
    if (crazyMode < 0) {
      crazyMode = 2;
    }
  } else if (mouseX < arrow4x + (arrow2w/2) && mouseX > arrow4x - (arrow2w/2) && mouseY < arrow4y + (arrow2h/2) && mouseY > arrow4y - (arrow2h/2)) {

    crazyMode++;
    if (crazyMode > 2) {
      crazyMode = 0;
    }
  } else if (mouseX < arrow5x + (arrow2w/2) && mouseX > arrow5x - (arrow2w/2) && mouseY < arrow5y + (arrow2h/2) && mouseY > arrow5y - (arrow2h/2)) {

    aiMode -= 1;
    if (aiMode < 0) {
      aiMode = 3;
    }
  } else if (mouseX < arrow6x + (arrow2w/2) && mouseX > arrow6x - (arrow2w/2) && mouseY < arrow6y + (arrow2h/2) && mouseY > arrow6y - (arrow2h/2)) {

    aiMode += 1;
    if (aiMode > 3) {
      aiMode = 1;
    }
  } else if (mouseX < arrow7x + (arrow2w/2) && mouseX > arrow7x - (arrow2w/2) && mouseY < arrow7y + (arrow2h/2) && mouseY > arrow7y - (arrow2h/2)) {
    pup -= 1;
    if (pup < 0) {
      pup = 4;
    }
  } else if (mouseX < arrow8x + (arrow2w/2) && mouseX > arrow8x - (arrow2w/2) && mouseY < arrow8y + (arrow2h/2) && mouseY > arrow8y - (arrow2h/2)) {
    pup += 1;
    if (pup > 4) {
      pup = 0;
    }
  }
  if ((scene == 6 || scene == 3 || scene == 8) && changed == false) {
    changed = true;
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.dx = -displayWidth*.008;
    }
   
  }
  if (scene == 1) {

    if (mouseX < button1x + (buttonw/2) && mouseX > button1x - (buttonw/2) && mouseY < button1y + (buttonh/2) && mouseY > button1y - (buttonh/2)) {
      scene = 2;
    } else if (mouseX < button2x + (buttonw/2) && mouseX > button2x - (buttonw/2) && mouseY < button2y + (buttonh/2) && mouseY > button2y - (buttonh/2)) {
      projScene = 3;
      reset();
    } else if (mouseX < button4x + (buttonw/2) && mouseX > button4x - (buttonw/2) && mouseY < button4y + (buttonh/2) && mouseY > button4y - (buttonh/2)) {
      scene = 7;
    } else if (mouseX < button5x + (buttonw/2) && mouseX > button5x - (buttonw/2) && mouseY < button5y + (buttonh/2) && mouseY > button5y - (buttonh/2)) {
      scene = 9;
    }
  }
  if (scene == 4 || scene == 10) {
    if (mouseX > share.x - share.w/2 && mouseX < share.x + share.w/2 && mouseY > share.y-share.h/2 && mouseY < share.y+share.h/2) {
      link("http://www.processing.org");
    } else if (mouseX > rate.x - rate.w/2 && mouseX < rate.x + rate.w/2 && mouseY > rate.y-rate.h/2 && mouseY < rate.y+rate.h/2) {
      link("http://www.processing.org");
    }
  }
}


void saveData() {
  SharedPreferences sharedPreferences;
  SharedPreferences.Editor editor;
  Activity act;
  act = this.getActivity();
  sharedPreferences = PreferenceManager.getDefaultSharedPreferences(act.getApplicationContext()); 
  editor = sharedPreferences.edit();
  editor.putInt("Highscore", highscore);
  editor.commit();
}
void loadData() {
  SharedPreferences sharedPreferences;
  Activity act;
  act = this.getActivity();
  sharedPreferences = PreferenceManager.getDefaultSharedPreferences(act.getApplicationContext()); 
  highscore = sharedPreferences.getInt("Highscore", highscore);
}

public boolean surfaceTouchEvent(MotionEvent me) {
  int numTouches = me.getPointerCount();
  if (scene == 1) {
    
  } else {
    for (int i=0; i < numTouches; i++) { 
     int pointerId = me.getPointerId(i);
      if (scene == 3 || scene == 6) {
        if (me.getX(i) > displayWidth/2 && abs(me.getY(i) - player2.y) <= 200 && me.getY(i) < displayHeight - player2.h/2 && me.getY(i) > player1.h/2) {
          player2.y = me.getY(i);
        }
      } else if (scene == 8) {
        float boundsY = player1.h/2;
        float boundsY2 = player2.h/2;
        float bounds2 = player1.y;
        float bounds3 = player2.y;
        float bounds4 = 200; 
        float bounds5 = 200; 
        if (crazyMode == 2) {
          boundsY = platform1.get(0).h*1.5;
          boundsY2 = platform2.get(0).h*1.5;
          fill(255); 
          System.out.println(boundsY);
          bounds2 = platform1.get(4).y;
          bounds3 = platform2.get(4).y;
          /*
          bounds4 = (platform1.get(8).y+platform1.get(8).h/2) - (platform1.get(0).y-platform1.get(0).h/2)/2;
          bounds5 = (platform2.get(8).y+platform2.get(8).h/2) - (platform2.get(0).y-platform2.get(0).h/2)/2;
          */
        }
        if (me.getX(i) < displayWidth/2 && abs(me.getY(i) - bounds2) <= bounds4 && me.getY(i) < displayHeight - boundsY && me.getY(i) > boundsY) {
          if (crazyMode != 2) {
            player1.y = me.getY(i);
          }
          else {
            for (int j = 0; j < platform1.size(); j++) {
              if (platform1.get(j).type == 1) {
                platform1.get(j).y = (displayHeight/6 + me.getY(i));
              }
              else if (platform1.get(j).type == 2) {
                platform1.get(j).y = me.getY(i);
              }
              else {
                platform1.get(j).y = (me.getY(i) - displayHeight/6);
              }
            }
          }
        } else if (me.getX(i) > displayWidth/2 && abs(me.getY(i) - bounds3) <= bounds5 && me.getY(i) < displayHeight - boundsY2 && me.getY(i) > boundsY2) {
  
          if (crazyMode != 2) {
            player2.y = me.getY(i);
          }
          else {
            for (int j = 0; j < platform2.size(); j++) {
              if (platform2.get(j).type == 1) {
                platform2.get(j).y = (displayHeight/6 + me.getY(i));
              }
              else if (platform2.get(j).type == 2) {
                platform2.get(j).y = me.getY(i);
              }
              else {
                platform2.get(j).y = (me.getY(i) - displayHeight/6);
              }
            }
          }
        }
      }
    }
  }
  return super.surfaceTouchEvent(me); 
}
void playSound(int soundID) {
  //play(int soundID, float leftVolume, float rightVolume, int priority, int loop, float rate)
  soundPool.stop(streamId);
  streamId = soundPool.play(soundID, 1.0, 1.0, 1, 0, 1f);
}
void powerup() {

  if (start2) {
      begin2 = millis();
      start2 = false;
  }
  float interval = random(3, 7); 
  float time = interval-int((millis()-begin2)/1000);
  if (time <= 0) {

    int prob = int(random(5));
    if (prob == 0) {
      px = random(displayWidth*1/5, displayWidth*4/5);
      py = random (displayHeight*1/5, displayHeight*4/5);
      powerups.add(new powerUp(px, py, 1));
      
    } else if (prob == 1) {
      px = random(displayWidth*1/5, displayWidth*4/5);
      py = random (displayHeight*1/5, displayHeight*4/5);
      powerups.add(new powerUp(px, py, 2));
    } else if (prob == 2) {
      px = random(displayWidth*1/5, displayWidth*4/5);
      py = random (displayHeight*1/5, displayHeight*4/5);
      powerups.add(new powerUp(px, py, 3));
    } else if (prob == 3) {
      px = random(displayWidth*1/5, displayWidth*4/5);
      py = random (displayHeight*1/5, displayHeight*4/5);
      powerups.add(new powerUp(px, py, 4));
    } else if (prob == 4) {
      px = random(displayWidth*1/5, displayWidth*4/5);
      py = random (displayHeight*1/5, displayHeight*4/5);
      powerups.add(new powerUp(px, py, 5));
    }
    
    start2 = true;
    
  }
  
  if (startTime) {
    if (timer) {
      start = millis();
      timer = false;
    }
    pupTime = 5-int((millis()-start)/1000);
    
    if (pupTime <= 0) {
      for (int i = 0; i < balls.size(); i++) {
        ball ballz = balls.get(i);
        ballz.speed = currentspd;
      }
      startTime = false; 
    }
  }
  
}
void createLogo()
{

  if (height>width)
  {
    background(0);
    float widthL = width * .7142857;
    image(logo[0], width * .14285714, height * .001, widthL, .7 *widthL );

    if (frameCount>=122)
    {
      image(logo[1], 0, 0, width, height);
    }
    if (frameCount>=126)
    {

      image(logo[2], 0, 0, width, height);
      image(logo[0], width * .14285714, height * .001, widthL, .7 *widthL );
      image(logo[4], width*.1428571427, height*.4, width*.7142857143, width*.7142857143);
    }
    if (frameCount>=170)
    {
      projScene = 1;
      scene = 99;
    }
  } else
  {
    background(0);
    float widthL = width * .5;
    image(logo[0], width * .25, height * .001, widthL, .7 *widthL );

    if (frameCount>=122)
    {
      image(logo[1], 0, 0, width, height);
    }
    if (frameCount>=126)
    {

      image(logo[2], 0, 0, width, height);
      //words
      image(logo[0], width * .25, height * .001, widthL, .7 *widthL );
      //logos

      image(logo[4], width*.359375, height*.45, height*.45, height*.45);
    }
    if (frameCount>=170)
    {
      projScene = 1;
      scene = 99;
    }
  }
}
void howtoplayscreen() {
  background(0);
  fill(255);
  textSize(48);
  text("Back", displayWidth/5.75, displayHeight/8.25);
  fill(0);
  stroke(255);
  rect(backbtnx, backbtny, backbtnw, backbtnh);
  fill(255);
  triangle(backbtnx-backbtnw/2, backbtny, backbtnx+backbtnw/2, backbtny-backbtnh/2, backbtnx+backbtnw/2, backbtny+backbtnh/2);
  textSize(60);
  text("HOW TO PLAY", displayWidth/2, displayHeight/2*.25);
  textSize(32);
  text("SINGLE PLAYER: DRAG THE RIGHT PLATFORM TO MOVE BOTH", displayWidth/2, displayHeight/2*.5);
  text("TWO PLAYER: PLAYER ONE DRAG THE LEFT PLATFORM, PLAYER TWO DRAG THE RIGHT PLATFORM", displayWidth/2, displayHeight/2*.75);
  text("PLAY AGAINST AI: DRAG THE RIGHT PLATFORM AND PLAY AGAINST AN AI", displayWidth/2, displayHeight/2);
  text("CRAZY MODE: ENABLE POWERUPS (SLOWDOWN, PLATFORM SIZE CHANGE, ETC.)", displayWidth/2, displayHeight/2*1.25);
  text("POWER UPS:", displayWidth/2*.88, displayHeight/2*1.5);
  fill(0);
  stroke(255);
  rect(arrow7x, arrow7y, arrow1h, arrow1w);
  fill(255);
  triangle(arrow7x-arrow1w/2, arrow7y, arrow7x+arrow1w/2, arrow7y-arrow1h/2, arrow7x+arrow1w/2, arrow7y+arrow1h/2);
  fill(0);
  stroke(255);
  rect(arrow8x, arrow8y, arrow1h, arrow1w);
  fill(255);
  triangle(arrow8x+arrow2w/2, arrow8y, arrow8x-arrow2w/2, arrow8y-arrow2h/2, arrow8x-arrow2w/2, arrow8y+arrow2h/2);
  image(pups[pup], displayWidth/2*1.2031, displayHeight/2*1.399, displayWidth*.038, displayWidth*.038);
  if (pup == 0) {

    text("SHRINK: PERMANENTLY SHRINKS THE PLATFORM'S SIZE", displayWidth/2, displayHeight/2*1.75);
  } else if (pup == 1) {
    text("EXPAND: PERMANENTLY ENLARGES THE PLATFORM'S SIZE", displayWidth/2, displayHeight/2*1.75);
  } else if (pup == 2) {
    text("REMOVE: PERMANENTLY REMOVES A BALL", displayWidth/2, displayHeight/2*1.75);
  } else if (pup == 3) {
    text("DUPLICATE: PERMANENTLY ADDS A BALL", displayWidth/2, displayHeight/2*1.75);
  } else {
    text("SPEED: INCREASES THE SPEED TEMPORARILY FOR 10 SECONDS", displayWidth/2, displayHeight/2*1.75);
  }     
  if (mouseX < backbtnx + (backbtnw/2) && mouseX > backbtnx - (backbtnw/2) && mouseY < backbtny + (backbtnh/2) && mouseY > backbtny - (backbtnh/2)) {
    projScene = 1;
    scene = 99;
  }
 
}
void pause() {
  
  rect(pausebtnx-displayWidth*.0088, pausebtny, pausebtnw, pausebtnh);
  rect(pausebtnx+displayWidth*.0088, pausebtny, pausebtnw, pausebtnh);
  if (scene == 8) {
    rect(pausebtnx2-displayWidth*.0088, pausebtny, pausebtnw, pausebtnh);
    rect(pausebtnx2+displayWidth*.0088, pausebtny, pausebtnw, pausebtnh);
    if (mouseX < pausebtnx2+displayWidth*.01570 + (pausebtnw/2) && mouseX > pausebtnx2-displayWidth*.01570 - (pausebtnw/2) && mouseY < pausebtny + (pausebtnh/2) && mouseY > pausebtny - (pausebtnh/2)) {
      scene = 11;
    }
  }
  if (mouseX < pausebtnx+displayWidth*.01570 + (pausebtnw/2) && mouseX > pausebtnx-displayWidth*.01570 - (pausebtnw/2) && mouseY < pausebtny + (pausebtnh/2) && mouseY > pausebtny - (pausebtnh/2)) {
    prevScene = scene;
    scene = 11;
  }
}
void unpause(int dest) {
  text("Paused", displayWidth/2, displayHeight*.4);
  fill(255);
  triangle(unpausebtnx+unpausebtnw/2, unpausebtny, unpausebtnx-unpausebtnw/2, unpausebtny-unpausebtnh/2, unpausebtnx-unpausebtnw/2, unpausebtny+unpausebtnh/2);
  fill(0);
  stroke(255);
  rect(pmenubtnx, pmenubtny, buttonw, buttonh);
  fill(255);
  textSize(48);
  text("Main Menu", pmenubtnx, pmenubtny);
  if (mouseX < pmenubtnx + (buttonw/2) && mouseX > pmenubtnx - (buttonw/2) && mouseY < pmenubtny + (buttonh/2) && mouseY > pmenubtny - (buttonh/2)) {
    projScene = 1;
    scene = 99;
  }
  if (mouseX < unpausebtnx + (unpausebtnw/2) && mouseX > unpausebtnx - (unpausebtnw/2) && mouseY < unpausebtny + (unpausebtnh/2) && mouseY > unpausebtny - (unpausebtnh/2)) {
    scene = dest;
  }
}

 
  
