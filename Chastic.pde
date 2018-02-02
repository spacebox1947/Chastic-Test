class Chastic {
  /*
  * Chastic is a drunken walk in 2 dimensions, with memory of the last step.
  *
  * It assumes weights are floats between 0.0 and wT or sT.
  * wT and sT default to 1.0 unless otherwise changed.
  *
  * incrementInput() returns a float of increment * sign.
  *
  * Could use some feedback, to make the randomness interesting!
  */
  
  float wT, sT;
  float wC, sC;
  float inc;
  float sign = 1.0;
  float incTruth = 0.0;
  float wF, sF;
  
  Chastic (float weight, float signWeight, float increment) {
    wC = weight;
    sC = signWeight;
    inc = increment;
    wT = 1.0;
    sT = 1.0;
  }
  
  // ---- Sign : Get, Set, and State----
  void setSign(boolean positive) {
    if (positive == true) {
      sign = 1;
    }
    else {
      sign = -1;
    }
  }
  
  void flipSign() {
    sign = -1*sign;
  }
  
  float getSign() {
    return sign;
  }
  
  boolean isSignPositive() {
    if (sign + abs(sign) == 0) {
      return false;
    }
    else {
      return true;
    }
  }
  
  // ---- inc and truthiness: how much to increment by, and wether-or-not to do so ----
  void setIncrement(float newInc) {
    inc = newInc;
  }
  
  float getIncrement() {
    return inc;
  }
  
  void setTruthiness(boolean newTruthiness) {
    if (newTruthiness == true) {
      incTruth = 1.0;
    }
    else {
      incTruth = 0.0;
    }
  }
  
  void flipTruthiness() {
    if (incTruth == 0.0) {
      incTruth += 1.0;
    }
    else {
      incTruth = 0.0;
    }
  }
  
  float getTruthiness() {
    return incTruth;
  }
  
  // ---- increment function: the meat of the operation! ----
  float incrementInput() {
    float tempVal;
    tempVal = (inc * incTruth * sign);
    return tempVal;
  }
  
  // ---- Roll! Let's Play some dice! ----
  void rollCtl(boolean rollW, boolean rollS) {
    //println("Rolling Increment: " + str(rollW) + "\tRolling Sign Change: " + str(rollS));
    if (rollW == true) {
      rollInc();
    }
    if (rollS == true) {
      rollSign();
    }
  }
  
  void rollInc() {
    float roll = random(0.0, wT);
    if (roll <= wC) {
      setTruthiness(true);
    }
    else {
      setTruthiness(false);
    }
  }
  
  void rollSign() {
    float roll = random(0.0, sT);
    if (roll <= sC) {
      flipSign();
    }
  }
  
  // ---- Weights & Probabilities ----
  void setTotals(float weightTotal, float signTotal) {
    /* 
    *  Takes two floats
    */
    wT = abs(weightTotal);
    sT = abs(signTotal);
    printProbabilities();
  }
  
  void printProbabilities() {
    float tW = wC / wT;
    float tS = sC / sT;
    println("Increment Probability:\t" + str(tW) + "%");
    println("Sign Change Probability:\t" + str(tS) + "%");
  }
  
  void printParams() {
    println("Increment: " + str(inc) + "\tSign: " + str(sign));
    println("Increment Probability Range: [" + str(0) + ", " + str(wT) + "]");
    println("Sign Change Probability Range: [" + str(0) + ", " + str(sT) + "]");
    printProbabilities();
    println();
  }
}