/**
 * Drift
 * by CalsignLabs
 * 
 * Touch the screen to manipulate the 
 * particles. Multi-touch is supported.
 */

// Used for multi-touch
import android.view.MotionEvent;

// Array of particles
Particle[] particles;

// Used for multi-touch
MouseTouch[] mouse;
float pointers;

void setup() {
  // Use OpenGL
  size(displayWidth, displayHeight, OPENGL);
  
  // Initialize multi-touch
  mouse = new MouseTouch[10];
  for (int i = 0; i < mouse.length; i ++) {
    mouse[i] = new MouseTouch();
  }
  
  // Set up random noise
  noiseDetail(16, 0.6);
  
  // Use HSB
  colorMode(HSB, 100, 100, 100, 100);
  strokeWeight(8);
  
  initGrid();
}

void initGrid() {
  // Reset to a grid of particles
  
  // Space between particles
  int inc = 70;
  // Number of particles that will fit
  int px = (int) width / inc;
  int py = (int) height / inc;
  
  // Initialize particle array
  particles = new Particle[px * py];
  
  // Populate particle array in a 
  // grid of reguarly-spaced particles
  int cur = 0;
  for (int x = 0; x < px; x ++) {
    for (int y = 0; y < py; y ++) {
      particles[cur] = new Particle(
          inc / 2 + x * inc, 
          inc / 2 + y * inc);
      cur ++;
    }
  }
}

void draw() {
  // Clear the background
  background(0);
  
  // Cycle through the particles
  for (int i = 0; i < particles.length; i ++) {
    particles[i].update();
    particles[i].display();
  }
}

// Detect (multiple) touches
public boolean surfaceTouchEvent(MotionEvent me) {
  // Don't detect touches at the very beginning
  if (frameCount > 0 && millis() > 500) {
    pointers = me.getPointerCount();
    
    // Clear old information
    for (int i = 0; i < mouse.length; i ++) {
      mouse[i].pressed = false;
    }
    
    // Update information
    for (int i = 0; i < mouse.length; i ++) {
      if (i < pointers) {
        mouse[i].update(me, i);
      } else {
        mouse[i].update();
      }
    }
    
    // Don't keep lift events
    if (me.getActionMasked() == MotionEvent.ACTION_UP) {
      mouse[me.getActionIndex()].pressed = false;
    }
  }
  
  return super.surfaceTouchEvent(me);
}

// Used to store multi-touch information
class MouseTouch {
  float x, y;
  float size;
  int id;
  boolean pressed;
  
  // Update values
  void update(MotionEvent me, int index) {
    x = me.getX(index);
    y = me.getY(index);
    size = (me.getTouchMajor(index) 
        + me.getTouchMinor(index)) / 2;
    
    id = me.getPointerId(index);
    pressed = true;
  }
  
  // Disable this touch
  void update() {
    pressed = false;
  }
}
