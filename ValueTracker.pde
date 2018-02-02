class ValueTracker {
  /*
  * Clunky as it may be, ValueTracker generates a 1D arrays of floats or ints.
  * You can call upon these with poorly named functions, and even
  * gather useful things like the least, greatest, and average values of the list.
  * 
  *  Designed to easily track values for 'Errata In Grey' animated score.
  * 
  * Noteable features: Appending a new element to the list also sends that value to an
  * accumulator, if accumulator is set to true.
  *
  * To Do / Issues: 
  *  - Error handling. There is none. Fix that. Now!
  *  - Opmtimize performance
  *  - Feature Creep: Move Least, Greatest, Average to a Stats Class. Add: Mean, Median, Mode, Standard Deviation.
  */
  // 1D data arrays
  float[] fList;
  int[] iList;
  // accumulators
  boolean acc;
  float accF;
  int accI;
  
  ValueTracker(boolean accumulate) {
    fList = new float[0];
    iList = new int[0];
    acc = accumulate;
  }
  
  // ---- fList Functions ----
  void appendFloatList(float newVal) {
    fList = append(fList, newVal);
    if (acc == true) {
      accumulateFloat(newVal);
    }
  }
  
  void accumulateFloat(float newVal) {
    accF += newVal;
  }
  
  float getFloatListIndex(int index) {
      return fList[min(max(0, index), fList.length)];
  }
  
  float[] getFloatList() {
    return fList;
  }
  
  float getFloatListTotal() {
    float temp = 0.0;
    for (int i = 0; i < fList.length; i++) {
      temp += fList[i];
    }
    return temp;
  }
  
  float getAccumulateFloat() {
    return accF;
  }
  
  float getFloatListGLA(int type) {
    /*
    * -1 returns Least
    * 0 returns Average
    * 1 returns Greatest
    */
    float temp = 0.0;
    switch(type) {
      case -1:
        temp = fList[0];
        for (int i = 0; i < fList.length; i++) {
          if (fList[i] < temp) {
            temp = fList[i];
          }
        }
        break;
      case 0:
        for (int i = 0; i < fList.length; i++) {
          temp += fList[i];
        }
        temp = temp / float(fList.length);
        break;
      case 1:
        temp = fList[0];
        for (int i = 0; i < fList.length; i++) {
          if (fList[i] > temp) {
            temp = fList[i];
          }
        }
        break;
    }
    return temp;
  }
  
  // ---- iList Functions ----
  void appendIntList(int newVal) {
    iList = append(iList, newVal);
    if (acc == true) {
      accumulateInt(newVal);
    }
  }
  
  void accumulateInt(int newVal) {
    accI += newVal;
  }
  
  int getIntListIndex(int index) {
      return iList[min(max(0, index), iList.length)];
  }
  
  int[] getIntList() {
    return iList;
  }
  
  int getIntListTotal() {
    int temp = 0;
    for (int i = 0; i < iList.length; i++) {
      temp += iList[i];
    }
    return temp;
  }
  
  int getAccumulateInt() {
    return accI;
  }
  
  int getIntListGLA(int type) {
    /*
    * -1 returns Least
    * 0 returns Average
    * 1 returns Greatest
    */
    int temp = 0;
    switch(type) {
      case -1:
        temp = iList[0];
        for (int i = 0; i < iList.length; i++) {
          if (iList[i] < temp) {
            temp = iList[i];
          }
        }
        break;
      case 0:
        for (int i = 0; i < fList.length; i++) {
          temp += iList[i];
        }
        temp = temp / iList.length;
        break;
      case 1:
        temp = iList[0];
        for (int i = 0; i < iList.length; i++) {
          if (iList[i] > temp) {
            temp = iList[i];
          }
        }
        break;
    }
    return temp;
  }
  
  // ---- General Functions! ----
  int getLength(int listType) {
    /*
    * 0 = iList (int)
    * 1 = fList (float)
    */
    int temp = 0;
    switch(listType) {
      case 0:
        temp = iList.length;
        break;
      case 1:
        temp = fList.length;
        break;
    }
    return temp;
  }
}