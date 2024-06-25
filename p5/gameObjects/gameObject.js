class gameObject {

    draw() {
        console.error("Draw has been called for non-drawable object");
    }

    update() {
        console.error("Update has been called for non-updatable object");
    }

    clickedOn() {
        console.error("Clickon has been called for non-clickable object");
    }

    hit(mousePos) {
        console.error("colission not set");
        return false;
    }

    rclickedOn() {
        console.error("rclickedOn has been called for non-rightclickable object");
    }
}