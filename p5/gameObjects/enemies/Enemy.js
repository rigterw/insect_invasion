class Enemy extends GameObject {

    size = 32;
    rotation = 0;
    vX = 0;
    vY = 0;
    maxV = 6;
    constructor(posX, posY) {
        super();
        this.x = posX;
        this.y = posY;
    }

    draw() {
        push();
        imageMode(CENTER);
        translate(this.x, this.y);
        let img = IMG["enemy"];
        
        if (this.vX != 0 || this.vY != 0) {
            this.rotation = atan2(this.vY, this.vX) + Math.PI * 0.5;
            img = getAnim("enemyWalk", 30);
        }
        rotate(this.rotation);
        image(img, 0, 0, this.size, this.size);
        pop();
    }

    update() {
        this.x += this.vX * this.maxV;
        this.y += this.vY * this.maxV;
    }

    killedPlayer(player) {
        return dist(player.x, player.y, this.x, this.y) < (player.size + this.size) / 2;
    }

    getImage() {
        return IMG["enemy"];
    }
}