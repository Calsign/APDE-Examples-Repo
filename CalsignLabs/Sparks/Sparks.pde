/**
 * Sparks
 * by CalsignLabs
 * 
 * Tap to create a new Spark.
 * 
 * This example uses the VIBRATE 
 * permission to vibrate the device 
 * when a Spark is created.
 */

// Import the Android Vibrator
// and Context classes
import android.os.Vibrator;
import android.content.Context;

// List of Sparks
ArrayList<Spark> sparks;

void setup() {
  // Use OpenGL
  size(displayWidth, displayHeight, OPENGL);
  
  sparks = new ArrayList<Spark>();
  
  // Switch to HSB for cool color blending
  colorMode(HSB, 360, 100, 100);
  strokeCap(ROUND);
  
  frameRate(60);
  smooth(8);
}

void draw() {
  // Fade-draw the background
  fill(0, 25);
  noStroke();
  rect(0, 0, width, height);
  
  // Cycle through the Sparks
  for (Spark spark : sparks) {
    spark.update();
    spark.display();
  }
}

void mousePressed() {
  // Add new Spark
  sparks.add(new Spark());
  // Vibrate
  ((Vibrator) getContext().getSystemService(Context.VIBRATOR_SERVICE)).vibrate(100);
}
