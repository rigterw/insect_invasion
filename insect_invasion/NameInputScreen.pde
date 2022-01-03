class NameInput {

  final int LETTERCOUNT = 7;

  int[] counters = new int[LETTERCOUNT];

  String[] Letters = new String[LETTERCOUNT];

  int textSize = 100;
  int offset = 50;

  int selected = 0;

  String name;

  void draw() {
    background(100, 200, 100);

    for (int i= 0; i < LETTERCOUNT; i++) {
      Letters[i] = Getletter(counters[i]);
    }
    drawText();

    name = join(Letters, "");

    rectMode(CORNER);
    rect(selected*textSize-offset+width/4, height/2, textSize, 10);
  }




  void keyPressed() {
    if (keyCode == 87)
    {
      if (!(selected >= LETTERCOUNT)) {
        counters[selected]++;
      }
    } else if (keyCode == 83)
    {
      if (!(counters[selected] <= 0)) {
        counters[selected]--;
      } else if (counters[selected] == 0) {
        counters[selected] = 26;
      }
    } else if (keyCode == 65)
    {
      if (!(selected < 0)) {
        selected--;
      }
    }
    //checking if the player wants to move to the right
    else if (keyCode == 68)
    {
      selected++;
    }


    for (int i = 0; i < LETTERCOUNT; i++) {
      if (counters[i] >= 27) {
        counters[i] = 0;
      }
    }
    if (selected >= 7 || selected < 0) {
      selected = 0;
    }
  }


  void drawText() {
    textSize(textSize);
    textAlign(CENTER);

    for (int i = 0; i < LETTERCOUNT; i++) {
      if (Letters[i] != null) {
        text(Letters[i], width/4+textSize*i, height/2);
      }
    }
  }

  String Getletter(int number) {

    switch(number) {
    case 0:
      return "A";
    case 1:
      return "B";
    case 2:
      return "C";
    case 3:
      return "D";
    case 4:
      return "E";
    case 5:
      return "F";
    case 6:
      return "G";
    case 7:
      return "H";
    case 8:
      return "I";
    case 9:
      return "J";
    case 10:
      return "K";
    case 11:
      return "L";
    case 12:
      return "M";
    case 13:
      return "N";
    case 14:
      return "O";
    case 15:
      return "P";
    case 16:
      return "Q";
    case 17:
      return "R";
    case 18:
      return "S";
    case 19:
      return "T";
    case 20:
      return "U";
    case 21:
      return "V";
    case 22:
      return "W";
    case 23:
      return "X";
    case 24:
      return "Y";
    case 25:
      return "Z";
    case 26:
      return " ";
    }
    return null;
  }
}
