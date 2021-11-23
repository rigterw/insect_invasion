class Coin {
  float x, y; //Coin x en y position
  float w, h; //Coin width en height 
  float coinRadius; //Radius van de coin voor collision
  boolean isEnabled; //Boolean voor het aan en uitzetten van de coin.
  color coinColor; //Kleur van de coin
  color coinStroke; //Omlijning van de coin

Coin() { 
    w = 18;
    h = 20; 
    coinRadius = w/2;
    isEnabled = false;
    coinColor = color(250, 250, 0);
    coinStroke = color(250, 230, 0);
  }

  void place(float xPos, float yPos) { //Plaats de coin op een tile
   x = xPos;
   y = yPos;
   isEnabled = true;
  }

  void display() { //Show de coin
    if (isEnabled == true) {
      update();
      draw();
    }
  }

  void update() { //Checkt en update de collision tussen de coin en speler
    if (dist(x, y, p.x, p.y) < p.distance) { 
      pickUp();
    }
  }

  void draw() { //Tekent de coin in de scene
    stroke(coinStroke);
    fill(coinColor);
    ellipse(x, y, w, h);
    stroke(0);
  }

  void pickUp() {    //Functie voor het oppakken van de coin.
    p.score +=1;
    coinSound.play();
    isEnabled = false; //op false zodat de coin niet meer getekent wordt
  }
}
