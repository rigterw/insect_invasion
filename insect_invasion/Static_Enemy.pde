class StaticEnemy extends MainEnemy {

  StaticEnemy(int circleX, int circleY) {
    this.circleX = circleX;
    this.circleY = circleY;
  }

  void draw() {
    noStroke(); //enemy vision circle
    fill(0);
    noFill();
    ellipse(circleX, circleY, diameter+138, diameter+248);

    if(p.x >= diameter+648 && p.x <= diameter+758 && p.y >= diameter+87 && p.y <= diameter+126){
      circleY = 60;
    } else {
      circleY = 20;
    }
  
    stroke(2);
    super.draw();//inherits everything inside the draw of all enemy classes
  }
}
