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

static final String CONFIG_FILE = "save.txt";
boolean [] keys = new boolean[128]; 
ArrayList <powerUp> powerups = new ArrayList <powerUp> ();
ArrayList <ball> balls = new ArrayList <ball> ();
int p1score = 0;
int p2score = 0;
int soloscore = 0;
float button1x;
float button1y;
float button2x;
float button2y;
float button3x;  
float button3y;  
float button4x;
float button4y;
float button5x;
float button5y;
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
float arrow4x;
float arrow4y;
float backbtnx;
float backbtny;
float backbtnw;
float backbtnh;
float currentspd;
boolean timer;
float start;
int scorelimit = 5;
int highscore = 1;
float px, py;
boolean crazyMode = false;
boolean loop = true;
float speedChange = 1.025;
int scene = 0;
PImage slowdown;
PImage addBall;
PImage removeBall;
PImage expand;
PImage shrink;
PImage [] logo;
int x = 0;
int y = 0;
 
//PrintWriter output = createWriter("save.txt");
public void setup() {

  orientation(LANDSCAPE);
  frameRate(60);
  size(displayWidth, displayHeight);
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
  backbtnx = displayWidth/10;
  backbtny = displayHeight/9;
  backbtnw = displayWidth*.044;
  backbtnh = displayHeight*.074;
  menub = new ball(displayWidth*.3125, displayHeight*.556, displayWidth*.01, displayHeight*.017777, displayWidth*.013, 1);
  player1 = new platform(displayWidth*.0052, displayHeight/2, displayWidth*.05, displayHeight*.185);
  player2 = new platform(displayWidth*.9896, displayHeight/2, displayWidth*.05, displayHeight*.185);
  
  rectMode(CENTER);
  textSize(48);
  background(0);


  slowdown = loadImage("slowdown2.png");
  addBall = loadImage("add.png");
  removeBall = loadImage("removeball.png");
  expand = loadImage("expand.png");
  shrink = loadImage("shrink.png");

  logo = new PImage[5];
  for (int i = 0; i < logo.length; i++) {
    String filename = "startScreen" + i + ".gif";
    logo[i] = loadImage(filename);
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
}
public void draw() {
  saveData();
  if (scene == 0) {
    createLogo();
  } else if (scene == 99) {
     scorelimit = 5;
     reset();
     scene = 1;
  } 
  else if (scene == 1) {
   
    menu();
  } else if (scene == 2) {
    select();
  } else if (scene == 6) {
    background(0);
    text(p1score, displayWidth/10, 30);
    text(p2score, displayWidth/10*9, 30);

    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.display();
      ballz.collisions();
      ballz.move();
      ballz.win();
    }

    player1.display();
    player2.display();
    
    
    aiMovement();
    platBoundary();
    if (crazyMode) {
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
    ;
    text(frameRate, 200, 200);
    text(soloscore, displayWidth/2, 30);
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.display();
      ballz.collisions();
      ballz.move();
      ballz.gameover();
    }
    player1.display();
    player2.display();
    
    

    player1.y = player2.y;
    platBoundary();

    powerup();
    for (int i = 0; i < powerups.size(); i++) {
      powerUp powerup = powerups.get(i);
      powerup.display();
      if (powerup.collisions()) {
        powerups.remove(i);
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
    if (mouseX < button3x + (buttonw/2) && mouseX > button3x - (buttonw/2) && mouseY < button3y + (buttonh/2) && mouseY > button3y - (buttonh/2)) {
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
    if (mouseX < button3x + (buttonw/2) && mouseX > button3x - (buttonw/2) && mouseY < button3y + (buttonh/2) && mouseY > button3y - (buttonh/2)) {
      scene = 99;
    }
  } else if (scene == 7) {
    select();
  } else if (scene == 8) {
    background(0);
    text(p1score, displayWidth/10, 30);
    text(p2score, displayWidth/10*9, 30);

    player1.display();
    player2.display();
    
    
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      ballz.display();
      ballz.collisions();
      ballz.move();
      ballz.win();
    }
    if (crazyMode) {
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
  }
}

public void menu() {
  background(0);
  menub.display();
  menub.move();
  menub.collisions();
  menub.gameover();
  player1.display();
  player2.display();
  aiMovement();
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
 

 
  
  //noLoop();
}

public void reset() {
  balls.clear();
  balls.add(new ball(displayWidth/2, displayHeight/2, displayWidth*.008, 0, displayWidth*.013, 1.55));
  menub = new ball(displayWidth*.3125, displayHeight*.556, displayWidth*.01, displayHeight*.017777, displayWidth*.013, 1);
  powerups.clear();
  speedChange = 1.025;
  player1.y = displayHeight/2;
  player2.y = displayHeight/2;
  player1.h = displayHeight*.185;
  player2.h = displayHeight*.185;
  soloscore = 0;

  if (scene == 99) {
    p1score = 0;
    p2score = 0;
  }
}

public void aiMovement() {
  if (scene == 1) {
    if (menub.dx < 0) {
        if (menub.y > player1.y) {
          player1.y += menub.y - player1.y;
        } else if (menub.y < player1.y) {
          player1.y -= player1.y - menub.y;
        } else {
          player1.y += 0;
        }
    } else 
        if (menub.y > player2.y && menub.dx > 0) {
          player2.y += menub.y - player2.y;
        } else if (menub.y < player2.y) {
          player2.y -= player2.y - menub.y;
        } else {
          player2.y += 0;
        }
    } else {
    for (int i = 0; i < balls.size(); i++) {
      ball ballz = balls.get(i);
      if (player1.y > ballz.y) {
        player1.y -= 10;
       
      } else if (player1.y < ballz.y) {
        player1.y += 10;
         
      }
    }
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
  if (crazyMode) {
    text("YES", displayWidth*.763, displayHeight/2*.59);
  } else {
    text("NO", displayWidth*.763, displayHeight/2*.59);
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
 
  if (mouseX < button3x + (buttonw/2) && mouseX > button3x - (buttonw/2) && mouseY < button3y + (buttonh/2) && mouseY > button3y - (buttonh/2)) {
    if (scene == 7) {
      scene = 8;
    } else {
      scene = 6;
    }
  } else if (mouseX < backbtnx + (backbtnw/2) && mouseX > backbtnx - (backbtnw/2) && mouseY < backbtny + (backbtnh/2) && mouseY > backbtny - (backbtnh/2)) {
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

    crazyMode = false;
  } else if (mouseX < arrow4x + (arrow2w/2) && mouseX > arrow4x - (arrow2w/2) && mouseY < arrow4y + (arrow2h/2) && mouseY > arrow4y - (arrow2h/2)) {

    crazyMode = true;
  }
  if (scene == 1) {
    //loop();
    if (mouseX < button1x + (buttonw/2) && mouseX > button1x - (buttonw/2) && mouseY < button1y + (buttonh/2) && mouseY > button1y - (buttonh/2)) {
      scene = 2;
    } else if (mouseX < button2x + (buttonw/2) && mouseX > button2x - (buttonw/2) && mouseY < button2y + (buttonh/2) && mouseY > button2y - (buttonh/2)) {
      scene = 3;
    } else if (mouseX < button4x + (buttonw/2) && mouseX > button4x - (buttonw/2) && mouseY < button4y + (buttonh/2) && mouseY > button4y - (buttonh/2)) {
      scene = 7;
    } else if (mouseX < button5x + (buttonw/2) && mouseX > button5x - (buttonw/2) && mouseY < button5y + (buttonh/2) && mouseY > button5y - (buttonh/2)) {
      scene = 9;
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
  for (int i=0; i < numTouches; i++) { 
    int pointerId = me.getPointerId(i);
    if (scene == 3) {
      if (me.getX(i) > displayWidth/2 && abs(me.getY(i) - player2.y) <= 200 && me.getY(i) < displayHeight - player2.h/2 && me.getY(i) > player1.h/2) {
        player2.y = me.getY(i);
      }
    } else if (scene != 1){
      if (me.getX(i) < displayWidth/2 && abs(me.getY(i) - player1.y) <= 200 && me.getY(i) < displayHeight - player1.h/2 && me.getY(i) > player1.h/2) {

        player1.y = me.getY(i);
      } else if (me.getX(i) > displayWidth/2 && abs(me.getY(i) - player2.y) <= 200 && me.getY(i) < displayHeight - player2.h/2 && me.getY(i) > player1.h/2) {

        player2.y = me.getY(i);
      }
    }
  }
  return super.surfaceTouchEvent(me);
}
void playSound(int soundID) {
   // play(int soundID, float leftVolume, float rightVolume, int priority, int loop, float rate)
   soundPool.stop(streamId);
   streamId = soundPool.play(soundID, 1.0, 1.0, 1, 0, 1f);
}
void powerup() {

  if (millis()%250 == 0) {

    int prob = int(random(10));
    if (prob == 1) {
      px = random(200, 1000);
      py = random (200, 600);
      powerups.add(new powerUp(px, py, 80, 80, 1));
    } else if (prob == 2) {
      px = random(200, 1000);
      py = random (200, 600);
      powerups.add(new powerUp(px, py, 80, 80, 2));
    } else if (prob == 3) {
      px = random(200, 1000);
      py = random (200, 600);
      powerups.add(new powerUp(px, py, 80, 80, 3));
    } else if (prob == 4) {
      px = random(200, 1000);
      py = random (200, 600);
      powerups.add(new powerUp(px, py, 80, 80, 4));
    } else if (prob == 5) {
      px = random(200, 1000);
      py = random (200, 600);
      powerups.add(new powerUp(px, py, 80, 80, 5));
    }
  }
  if (timer) {
    if (frameCount - start  > 600 && timer) {
      for (int i = 0; i < balls.size(); i++) {
        ball ballz = balls.get(i);
        ballz.speed = currentspd;
      }
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
      image(logo[4], width*.1428571429, height*.4, width*.7142857143, width*.7142857143);
    }
    if (frameCount>=170)
    {
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
  if (mouseX < backbtnx + (backbtnw/2) && mouseX > backbtnx - (backbtnw/2) && mouseY < backbtny + (backbtnh/2) && mouseY > backbtny - (backbtnh/2)) {
    scene = 99;
  }
}
 
