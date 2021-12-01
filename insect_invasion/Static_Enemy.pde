class StaticEnemy extends MainEnemy {

  /*
   * 2 argument constructor from the StaticEnemy class
   * @param Integer circleX
   * @param Integer circleY
   */
  //StaticEnemy(int circleX_, int circleY_) {
  //  this.circleX = circleX_;
  //  this.circleY = circleY_;
  //}

  boolean scared = false;

  void placeStaticEnemy(float xPos_, float yPos_) {
    enemyX = xPos_;
    enemyY = yPos_;
    isEnabled = true;
  }

  /*
   * Method to draw the static enemy
   * @return void
   */
  void draw() {
    noStroke(); //enemy vision circle
    fill(0);
    noFill();
    //drawing enemy vision circle
    ellipse(enemyX, enemyY, enemyDiameter+138, enemyDiameter+248);

    //checks if player is within range of enemy vision circle
    if (p.x >= enemyDiameter+648 && p.x <= enemyDiameter+758 && p.y >= enemyDiameter+87 && p.y <= enemyDiameter+126) {
      if (scared == false) {
        enemyY = enemyY + 40;
        scared = true;
      }
    } else {
      enemyY = enemyY;
      scared = false;
  }

    stroke(2);
    super.draw();//inherits everything inside the draw of all enemy classes
  }
}
