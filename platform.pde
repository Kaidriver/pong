public class platform {
  
   private float x, y, w, h, type;
   
   public platform(float x, float y, float w, float h, int type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type; 
   }
   
   public void display () {
     fill(color(255,255,255));
     rect(x, y, w, h);
   }
   
   public void bounds() {
     // float temp = h/2;
     // y = y-temp < 0 ? temp : y + temp/2 > height ? height-temp : y;   
   }
}
