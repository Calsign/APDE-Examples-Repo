// Particle class
class Particle {
  PVector loc; // location
  PVector vel; // velocity
  PVector acc; // acceleration
  
  Particle(float x, float y) {
    // Initialize everything to 
    // default values
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void update() {
    // Re-calculate acceleration
    acc.x = 0;
    acc.y = 0;
    
    if (mousePressed && pointers > 0) {
      // Calculate average of all 
      // touch locations
      
      float mx = 0;
      float my = 0;
      
      int count = 0;
      
      // Add the positions
      for (int i = 0; i < mouse.length; i ++) {
        if (mouse[i].pressed) {
          mx += mouse[i].x;
          my += mouse[i].y;
          
          count ++;
        }
      }
      
      // Compute average
      mx = mx / count;
      my = my / count;
      
      if (!(mx != mx || my != my)) {
        // Calculate acceleration based
        // on relative location to the
        // average of the touch points
        acc.x = mx - loc.x;
        acc.y = my - loc.y;
        
        // Normalize the vector
        acc.normalize();
        acc.mult(4);
      }
    }
    
    // Add acceleration to velocity
    vel.add(acc);
    
    // Maximum velocity
    vel.limit(20);
    // A little bit of drag
    vel.mult(0.99);
    
    // Add velocity to location
    loc.add(vel);
  }
  
  void display() {
    // Don't display if we're off-screen
    if (loc.x > 0 && loc.x < width 
        && loc.y > 0 && loc.y < height) {
      
      // Color based on position on
      // the screen and time
      stroke(noise(loc.x / 1000, loc.y / 1000, 
          millis() / 1000.0) * 100, 
          random(50, 80), random(40, 90));
      
      // Draw the point
      point(loc.x, loc.y);
    }
  }
}
