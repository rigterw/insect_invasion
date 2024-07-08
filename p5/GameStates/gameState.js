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
        this.inputObjects = [];
        this.logicObjects = [];
    }

    handleInput(pressed) {
        this.inputObjects.forEach(element => {
            element.handleInput(pressed);
        })
    }

    
}