int numFrames = 35;  // The number of frames in the animation
int currentFrame = 0;
PImage[] images = new PImage[numFrames];
import processing.video.*;

Capture video;

color trackColor; 
float threshold = 25;

void setup() {
  size(1920, 1080);
  background(0);
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[3]);
  video.start();
  trackColor = color(255);
  smooth();
  frameRate(15);
  images[0]  = loadImage("spirea-1.png");
  images[1]  = loadImage("spirea-2.png"); 
  images[2]  = loadImage("spirea-3.png");
  images[3]  = loadImage("spirea-4.png"); 
  images[4]  = loadImage("spirea-5.png");
  images[5]  = loadImage("spirea-6.png"); 
  images[6]  = loadImage("spirea-7.png");
  images[7]  = loadImage("spirea-8.png");
  images[8]  = loadImage("spirea-9.png");
  images[9]  = loadImage("spirea-10.png");
  images[10]  = loadImage("spirea-11.png");
  images[11]  = loadImage("spirea-12.png");
  images[12]  = loadImage("spirea-13.png");
  images[13]  = loadImage("spirea-14.png");
  images[14]  = loadImage("spirea-15.png");
  images[15]  = loadImage("spirea-16.png");
  images[16]  = loadImage("spirea-17.png");
  images[17]  = loadImage("spirea-18.png");
  images[18]  = loadImage("spirea-19.png");
  images[19]  = loadImage("spirea-20.png");
  images[20]  = loadImage("spirea-21.png");
  images[21]  = loadImage("spirea-22.png");
  images[22]  = loadImage("spirea-23.png");
  images[23]  = loadImage("spirea-24.png");
  images[24]  = loadImage("spirea-25.png");
  images[25]  = loadImage("spirea-26.png");
  images[26]  = loadImage("spirea-27.png");
  images[27]  = loadImage("spirea-28.png");
  images[28]  = loadImage("spirea-29.png");
  images[29]  = loadImage("spirea-30.png");
  images[30]  = loadImage("spirea-31.png");
  images[31]  = loadImage("spirea-32.png");
  images[32]  = loadImage("spirea-33.png");
  images[33]  = loadImage("spirea-34.png");
  images[34]  = loadImage("spirea-35.png");
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  video.loadPixels();
  //image(video, 0, 0);

  //threshold = map(mouseX, 0, width, 0, 100);
  threshold = 7;

  float avgX = 0;
  float avgY = 0;

  int count = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      int loc = x + y * video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      float d = distSq(r1, g1, b1, r2, g2, b2); 

      if (d < threshold*threshold) {
        stroke(255);
        strokeWeight(1);
        point(x, y);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
   currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames
  int offset = 0;
  for (int x = width/2; x < width; x += images[0].width) { 
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
    // Draw a circle at the tracked pixel
    imageMode(CENTER);
    tint(255, 175);
 image(images[(currentFrame+offset) % numFrames], x, avgY*6, avgX*6, avgX*6);
    offset+=2;
    image(images[(currentFrame+offset) % numFrames], x, avgY*6, avgX*6, avgX*6);
    offset+=2;
  } 
  }
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
}

//void mousePressed() {
//  // Save color where the mouse is clicked in trackColor variable
//  int loc = mouseX + mouseY*video.width;
//  trackColor = video.pixels[loc];
//}
