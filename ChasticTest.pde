int CIRCLES = 8;
Chastic[] rando = new Chastic[CIRCLES];
ValueTracker[] seconds = new ValueTracker[CIRCLES];

float total = 0.0;
float xScale, yScale;
float[] input = {5.0, 7.5, 4.5, 8.0, 9.0, 7.5, 6.5, 5.0};

boolean incCtl = true;
boolean signCtl = false;

float[] result = new float[0];
float greatest = 0.0;

float graphBorder = 15;

// ---- Setup! Woot! ----
void setup() {
  size(1600, 200);
  background(255);
  rectMode(CORNER);
  
  // initialize Chastic(s) and ValueTracker(s)
  for (int i = 0; i < CIRCLES; i++) {
    rando[i] = new Chastic(.0375+((i%2) * .0075), .33, .125+(.125*i));
    rando[i].printParams();
    println();
    seconds[i] = new ValueTracker(true);
  }
}

// ---- Draw! Woot Woot! ----
void draw() {
  fill(196);
  rect(0,0,width,height);
  fill(255);
  rect(graphBorder, graphBorder, width-graphBorder*2, height-graphBorder*2);
  // ---- work through each seconds[n], accumulating and random walking ----
  for (int i = 0; i < CIRCLES; i++) {
    int j = 0;
    while (seconds[i].getAccumulateFloat() < 600.0) {
      if (j % (2+i) == 0) {
        signCtl = true;
      }
      else {
        signCtl = false;
      }
      rando[i].rollCtl(incCtl, signCtl);
      if (input[i] + (rando[i].getIncrement() * rando[i].getSign()) == 0 && rando[i].getTruthiness() == 1.0) {
        input[i] += abs(rando[i].incrementInput());
        // since this controls for going to 0.0,
        // it would be nice to add some functions to save this for feedback
      }
      else {
        input[i] += rando[i].incrementInput();
      }
      //println("Input: " + str(rando[i].getLastVal()) + "\tOutput: " + str(rando[i].getCurrVal()));
      //rando[i].printParams();
      seconds[i].appendFloatList(input[i]);
      //print(str(seconds[i].getLength(1)) + ", ");
      
      j += 1;
      total += input[i];
    }
  }
  println();
  
  // get seconds[i] with the greatest # of indices
  // get the greatest [i] value of all seconds[i]
  int greatestX = 0;
  float greatestY = 0.0;
  for (int i = 0; i < CIRCLES; i++) {
    if (seconds[i].getLength(1) > greatestX) {
      greatestX = seconds[i].getLength(1);
    }
    if (seconds[i].getFloatListGLA(1) > greatestY) {
      greatestY = seconds[i].getFloatListGLA(1);
    }
  }
  
  //uneccesarily bad graph markings
  yScale = (height - graphBorder*2) /  greatestY;
  println("Y-Scale: " + str(yScale));
  
  int steps = ceil((height - graphBorder*2) / yScale)+1;
  println(greatestY, yScale, steps);
  println();
  for (int i = 0; i < steps; i++) {
    stroke(2);
    noFill();
    line(graphBorder, graphBorder+(yScale*i), graphBorder-4, graphBorder+(yScale*i));
  }
  
  // graph the values!
  for (int j = 0; j < CIRCLES; j++) {
    println("Lowest Value in Seconds[]: " + str(seconds[j].getFloatListGLA(-1)));
    println("Highest Value in Seconds[]: " + str(seconds[j].getFloatListGLA(1)));
    println("Average of Values in Seconds[]: " + str(seconds[j].getFloatListGLA(0)));
    
    xScale = (width - graphBorder*2) / float(seconds[j].getLength(1));
    
    for (int i = 0; i < seconds[j].getLength(1); i++) {
      stroke(1);
      fill(256 - (128  / (j+1)));
      ellipse((i*xScale)+(xScale*.5)+graphBorder, abs((seconds[j].getFloatListIndex(i)*yScale)-(height-graphBorder)), 6, 6);
      if (i < seconds[j].getLength(1) - 1) {
        print(seconds[j].getFloatListIndex(i) + ", ");
      }
      else {
        println(seconds[j].getFloatListIndex(i));
      }
    }
    println("Total of all Increments: " + str(total) + "\t# of Indices: " + seconds[j].getLength(1));
    println();
  }
  
  noLoop();
}