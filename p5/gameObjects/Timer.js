class Timer extends GameObject{
    time = 45000; //Amount of starting time in ms
    maxTime = this.time; //Max amount of time in ms
    timerMaxWidth = 1280; //Max width timer
    timerHeight = 25; //Height timer
    nowTime; //Time passed since starting the game
    lastTime; //Last time the amount of time decreased
    timerWidth;

    constructor() {
        super();
        this.lastTime = millis();
    }
    
    draw() {
        fill(0);
        rect(0,0, width, this.timerHeight);
        const greenColor = this.time / this.maxTime *255 *2; //The timer transitions from green to red as time decreases
        const redColor = 255 *2 - this.time / this.maxTime * 255 *2;
        const  blueColor = 0;
        fill(redColor, greenColor, blueColor);

        noStroke();
        this.timerWidth = (this.time / this.maxTime) * this.timerMaxWidth;
        rect(0,0, this.timerWidth, this.timerHeight); //Drawing the timer
    }

    update() {
        if (this.time > this.maxTime) {
            this.time = this.maxTime; //Prevents the value of time exceeding the maximum
            this.timerWidth = this.timerMaxWidth; //Prevents the timer from being drawn wider than the maximum width
        }
        this.nowTime = millis(); //Decreasign the value of time
        this.time -= (this.nowTime - this.lastTime);
        if (this.achievementDisplayTime > 0) {
            this.achievementDisplayTime -= (this.nowTime - this.lastTime);
        }

        if (this.time < 0) {
            PlayState.instance.showGameOver();
        }

        this.lastTime = this.nowTime;
    }
}