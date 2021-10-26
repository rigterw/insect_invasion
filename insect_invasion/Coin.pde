class Coin {
  float x, y; //Coin x en y position
  float w, h; // Coin width en height 
  color coinColor; // Kleur van de coin
  boolean isEnabled; //Boolean voor het aan en uitzetten van de coin.
  float coinRadius;

  Coin(float xPos, float yPos) {
    x = xPos;
    y = yPos;
    w = 25;
    h = 25; 
    coinColor = color(250, 250, 0);
    isEnabled = true;
    coinRadius = w/2;
  }

  void update() {
      if (dist(x, y, p.x, p.y) < p.distance) { 
      if (isEnabled == true) {
        pickUp();
        p.score +=1;
        println("Coin picked up");
      }
    }
  }

  void draw() {
    fill(coinColor);
    ellipse(x, y, w, h);
  }

  void pickUp() {    //Functie voor het oppakken van de coin. 
    isEnabled = false; //op false zodat de coin niet meer getekent wordt.
  }
}
