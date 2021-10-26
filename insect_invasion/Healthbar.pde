class HealthBar {
  float health = 3;
  float MAX_HEALTH = 3;
  float rectWidth = 150;
  float rectHeight = 25;
  float healthBarX = 25;
  float healthBarY = 690;

  void draw()  {
    

    if (health < 2) // Past kleur van healthbar aan afhankelijk van de hoeveelheid health
    {
      fill(255, 0, 0);
    } else if (health < 3)
    {
      fill(255, 200, 0);
    } else
    {
      fill(0, 255, 0);
    }

    noStroke(); // Draw van de healthbar
    float drawWidth = (health / MAX_HEALTH) * rectWidth;
    float drawHeight = rectHeight;
    rect(healthBarX, healthBarY, drawWidth, drawHeight);

    stroke(0);
    noFill();
    rect(healthBarX, healthBarY, rectWidth, rectHeight); // Draw van healthbar outline
  }
}
