
class GameStateManager {
    constructor() {
        this.gameStates = {
            "PlayState": new PlayState(),
            "StartState": new StartState(),
            "ShopState": new ShopState()
        };

        this.switchState("StartState");
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

    restart() {
    }

    handleInput(pressed) {
        this.currentState.handleInput(pressed);
    }
}

