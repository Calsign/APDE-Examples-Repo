background(0);

// The number of rectangles
int count = width / 4;
// The width and height of the rectangles
int dimen = width / 20;

// Draw rectangles at random locations
// around the screen

for (int i = 0; i < count; i = i + 1) {
  // random() produces a random number
  // between the two given numbers
  rect(random(0, width), random(0, height), dimen, dimen);
}