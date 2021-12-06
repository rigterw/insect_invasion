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
    //Draws a vision circle on top of the enemy
    noFill();
    noStroke();
    ellipseMode(CENTER);

    float visionW = 250;
    float visionH = 250;
    float visionRadius =  visionW/2;
    float PlayerToEnemy = dist(enemyX, enemyY, p.x, p.y);
    
    ellipse(enemyX, enemyY, visionW, visionH);

    if (PlayerToEnemy <= p.radius + visionRadius) {
      enemyY = enemyY +1;
    }


    stroke(2);
    super.draw();//inherits everything inside the draw of all enemy classes
  }
}
