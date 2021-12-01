class Coin {
  float x, y; //Coin x en y position
  float w, h; //Coin width en height 
  float coinRadius; //Radius for the coin collision
  boolean isEnabled; //Boolean for enabling and disabling the coin
  color coinColor; //The color of the coin
  color coinStroke; //The outlining of the coin

  /*
   * No argument constructor for the Coin class
   */
  Coin() { 
    w = 18;
    h = 20; 
    coinRadius = w/2;
    isEnabled = false;
    coinColor = color(250, 250, 0);
    coinStroke = color(250, 230, 0);
  }

  /*
   * Method to place the Coin on the tile
   * @params float xPos
   * @params float yPos
   * @return void
   */
  void place(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    isEnabled = true;
  }

  /*
   * Method to display the Coin
   * @return void
   */
  void display() { 
    if (isEnabled == true) {

      //updating the collision
      update();

      //drawing the coin
      draw();
    }
  }

  /*
   * Method to check and update the collision between coin and player
   * @return void
   */
  void update() {
    if (dist(x, y, p.x, p.y) < p.distance) { 
      //picking up the coin
      pickUp();
    }
  }

  /*
   * Method to draw the coin
   */
  void draw() {
    stroke(coinStroke);
    fill(coinColor);
    ellipse(x, y, w, h);
    stroke(0);
  }

  /*
   * Method to pickup the coin
   * @return void
   */
  void pickUp() {
    //updating the score
    //p.score +=1;
    //adding the time
    timer.time += timer.extraTime;

    //playing the coin pickup sound
    coinSound.play();

    //disabling the coin so it wont be drawn anymore
    isEnabled = false;
    
    //Time++ :
    //
  }
}
