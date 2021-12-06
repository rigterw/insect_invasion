class Timer {
  float time = 60000; //Amount of starting time in ms
  float maxTime = time; //Max amount of time in ms
  int timerMaxWidth = 1280; //Max width timer
  int timerHeight = 25; //Height timer
  int timeBarX = 0; //Timer position X
  int timeBarY = 0; //Timer position Y
  int nowTime; //Time passed since starting the game
  int lastTime; //Last time the amount of time decreased
  int extraTime = 5000; //Amount of seconds added when grabbing a coin in MS
  float timerWidth;

  void drawTimer()
  {

    float greenColor = time / maxTime *255 *2; //The timer transitions from green to red as time decreases
    float redColor = 255 *2 - time / maxTime * 255 *2;
    float blueColor = 0;
    fill(redColor, greenColor, blueColor);

    noStroke();
    timerWidth = (time / maxTime) * timerMaxWidth;  //Width of the drawn timer
    if (time > maxTime) {
      time = maxTime; //Prevents the value of time exceeding the maximum
      timerWidth = timerMaxWidth; //Prevents the timer from being drawn wider than the maximum width
    }

    rect(timeBarX, timeBarY, timerWidth, timerHeight); //Drawing the timer
    nowTime = millis(); //Decreasign the value of time
    time -= (nowTime - lastTime);
    lastTime = nowTime;
    if (time<0) {
      stage = 4;
    }
  }
}
