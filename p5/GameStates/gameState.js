class GameState {
    visibleObjects = [];
    logicObjects = [];
    inputObjects = [];


    //iterates all the objects that needs to be updated each frame
    update() {
        this.logicObjects.forEach(element => {
            element.update();
        });
    }

    draw() {
        this.visibleObjects.forEach(element => {
            element.draw();
        });
    }

    clear() {
        this.visibleObjects = [];
        this.clickableObjects = [];
        this.rClickableObjects = [];
        this.logicObjects = [];
    }

    handleInput(pressed) {
        this.inputObjects.forEach(element => {
            element.handleInput(pressed);
        })
    }

    
}