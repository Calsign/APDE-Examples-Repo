/**
 * Drift
 * by CalsignLabs
 * 
 * Touch the screen to manipulate the 
 * particles. Multi-touch is supported.
 */

// Array of particles
Particle[] particles;

void setup() {
  // Use OpenGL
  fullScreen(OPENGL);
  
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