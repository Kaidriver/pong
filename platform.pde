public class platform {
   private float x, y, w, h;
   private color platColor = color(255,255,255);
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
   public void bounds() {
     if (y-h/2 <0) {
       y = h/2;
     }else if (y+h/2 > height) {
       y = height - h/2;
     }
        
   }
  

}
