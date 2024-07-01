class GameState {
    visibleObjects = [];
    clickableObjects = [];
    rClickableObjects = [];
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

    //iterates all the objects that can be clicked to find where the player clicked
    click(mousePos) {
        this.clickableObjects.forEach(element => {
            if (element.hit(mousePos)) {
                element.clickedOn();
                return;
            }
        });
    }

    rclick(mousePos) {
        this.clickableObjects.forEach(element => {
            if (element.hit(mousePos)) {
                element.rclickedOn();
                return;
            }
        });
    }

    handleInput() {
        this.inputObjects.forEach(element => {
            element.handleInput();
        })
    }
}