class StartState extends GameState {

    constructor() {
        super();
        this.visibleObjects.push(new TxtObject('Press "F" to start', width / 10 * 6, height / 8 * 7, 90));
    }
    draw() {
        image(IMG["startScreen"], 0, 0);
        super.draw();
    }

    handleInput(pressed) {
        if (!pressed)
            return;

        if (keyCode == 70) {
            gameStateManager.switchState("PlayState");
        }
    }
}