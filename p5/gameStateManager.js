
class GameStateManager {
    constructor() {
        this.gameStates = {};
    }
    switchState(stateName) {
        if (!(stateName in this.gameStates)) {
            console.error(`${stateName} doesn't exist`);
            return;
        }
        this.currentState = this.gameStates[stateName];
    }
    draw() {
        if (this.currentState == null || this.currentState == undefined)
            return;
        this.currentState.update();
        this.currentState.draw();
    }

    click(mousePos) {
        this.currentState.click(mousePos);
    }

    rclick(mousePos) {
        this.currentState.rclick(mousePos);
    }

    restart() {
    }
}

