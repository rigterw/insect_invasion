class StaticEnemy extends MainEnemy {

  /*
   * 2 argument constructor from the StaticEnemy class
   * @param Integer circleX
   * @param Integer circleY
   */
  StaticEnemy(int enemyX, int enemyY) {
    this.enemyX = enemyX;
    this.enemyY = enemyY;
  }

  /*
   * Method to draw the static enemy
   * @return void
   */
  void draw() {
    noStroke(); //enemy vision circle
    fill(0);
    noFill();
    //draws static enemy vision circle
    ellipse(enemyX, enemyY, enemyDiameter+138, enemyDiameter+248);

    //checks if player is within static enemy vision circle
    if (p.x >= enemyDiameter+648 && p.x <= enemyDiameter+758 && p.y >= enemyDiameter+87 && p.y <= enemyDiameter+126) {
      enemyY = 60;
    } else {
      enemyY = 20;
    }

    stroke(2);
    super.draw();//inherits everything inside the draw of all enemy classes
  }
}
