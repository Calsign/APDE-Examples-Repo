import processing.vr.*;

void setup() {
  fullScreen(STEREO);
}

void draw() {
  background(157);
  lights();
  translate(width/2, height/2);
  rotateX(frameCount * 0.01f);
  rotateY(frameCount * 0.01f);
  box(350);
}

