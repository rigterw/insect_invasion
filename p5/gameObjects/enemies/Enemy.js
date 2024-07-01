class Enemy extends GameObject {

    size = 32;
    rotation = 0;
    vX = 0;
    vY = 0;
    maxV = 3;
    constructor(posX, posY) {
        super();
        this.x = posX;
        this.y = posY;
    }

    draw() {
        push();
        imageMode(CENTER);
        translate(this.x, this.y);
        rotate(this.rotation);
        const img = this.getImage();
        image(img, 0, 0, this.size, this.size);
        pop();
    }

    getImage() {
        return IMG["enemy"];
    }
}