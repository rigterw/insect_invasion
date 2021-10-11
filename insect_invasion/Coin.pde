class Coin
{
  float x, y; //Coin x en y position
  float w, h; // Coin width en height 
  color coinColor = color(250, 250, 0); // Kleur van de coin
  boolean isEnabled; //Boolean voor het aan en uitzetten van de coin.
     
  void draw()
  {
     isEnabled = true;  //Zet de coin elk frame op true zodat deze in de scene blijft.
     x = 325; 
     y = 50; 
     w = 25;
     h = 25;
     
     fill(coinColor);
     ellipse(x, y, w, h);
  }

  void pickUp()    //Functie voor het oppakken van de coin. 
  {
    isEnabled = false;  // In main: zodra de player collision heeft met de coin wordt pickUp() aangeroepen  
                        // isEnabled wordt op false gezet zodat de coin niet meer getekent wordt. 
                        // In main: if (coin1.isEnabled == true) {  coin1.draw(); } 
    //nextLevel();
  }
}
