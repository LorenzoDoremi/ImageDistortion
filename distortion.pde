PImage img; // image to use
PImage store; // PImage to edit for calculations if you dont'want to use the canvas pixels
int power; // power of mouse distortion
PImage displacement; // displacement image in grayscale
int dimensioneDistortX = 2000; // displacement size
int dimensioneDistortY = 3000;// displacement size
int ratio = 16; // the lower, the more distortion you have

void setup() {
  size(700, 900, FX2D);
  img = loadImage("img.jpg");
  store = loadImage("img.jpg");
  displacement = loadImage("noise.jpg");
  img.resize(width +512/ratio, height + 512/ratio );
  store.resize(width +512/ratio, height + 512/ratio);
  displacement.resize(dimensioneDistortX, dimensioneDistortY);
  imageMode(CENTER);
}
int time = 1;

void draw() {

  for (int x = 0; x < img.width; x++) {

    for (int y = 0; y < img.height; y++) {
      // get the displacement brightness
      int bright = (int)brightness(displacement.get(
        (x+time)%displacement.width, 
        (y+time)%displacement.height
        )

        );
        
      power = (int)sqrt(10000000/(1+(int)pow(((int)dist(x, y, mouseX, mouseY)), 2)));
      // limit of mouse power
      int lim = 40;
      if (power > lim) power = lim;
      
      //get the translated color based on the displacement
      color c = img.get(
        x+bright/ratio + power, 
        y+bright/ratio + power 
        );

      /* remove comments to add noise
      int contrast = 10;
        int noise = (int)random(-contrast, contrast);
      c = color(red(c)+noise,green(c)+noise,blue(c)+noise);
      */
      set(x, y, c);
    }
  }
 
  time++;
}
