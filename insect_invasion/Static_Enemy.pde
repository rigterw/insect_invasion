class StaticEnemy extends MainEnemy {

  /*
   * 2 argument constructor from the StaticEnemy class
   * @param Integer circleX
   * @param Integer circleY
   */
  StaticEnemy(int circleX, int circleY) {
    this.circleX = circleX;
    this.circleY = circleY;
  }

  /*
   * Method to draw the static enemy
   * @return void
   */
  void draw() {
    noStroke(); //enemy vision circle
    fill(0);
    noFill();
    //drawing the enemy
    ellipse(circleX, circleY, diameter+138, diameter+248);

    //creator please comment this
    if (p.x >= diameter+648 && p.x <= diameter+758 && p.y >= diameter+87 && p.y <= diameter+126) {
      circleY = 60;
    } else {
      circleY = 20;
    }

    stroke(2);
    super.draw();//inherits everything inside the draw of all enemy classes
  }
}
