class Player extends GameObject {

    size = 24;
    maxV = 2;
    vX = 0; vY = 0;
    x = 0; y = 0;
    rotation = 0;
    imgName = "player"
    constructor() {
        super();
    }

    draw() {
        push();
        imageMode(CENTER);
        translate(this.x, this.y);
        rotate(this.rotation);

        let playerImg = IMG[this.imgName];

        if (this.vX != 0 || this.vY != 0) {
            playerImg = getAnim(`${this.imgName}Walk`, 30);
        }
        image(playerImg, 0, 0, this.size, this.size);
        pop();
    }

    update() {
        const left = keyIsDown(65) || keyIsDown(LEFT_ARROW);
        const right = keyIsDown(68) || keyIsDown(RIGHT_ARROW);
        const down = keyIsDown(83) || keyIsDown(DOWN_ARROW);
        const up = keyIsDown(87) || keyIsDown(UP_ARROW);


        if (left && !right) {
            this.vX = -this.maxV;
        } else if (!left && right) {
            this.vX = this.maxV;
        } else if (!left && !right) {
            this.vX = 0;
        }

        if (up && !down) {
            this.vY = -this.maxV;
        } else if (!up && down) {
            this.vY = this.maxV;
        } else if (!up && !down) {
            this.vY = 0;
        }

        if (this.vX != 0 || this.vY != 0) {
            this.rotation = atan2(this.vY, this.vX) + Math.PI * 0.5;
        }
        this.x += this.vX;
        this.y += this.vY;
    }

    handleTileColission(tiles) {

        if (tiles["R"] != undefined && !tiles["R"].passable) {
            let overflow = this.x + 0.5 * this.size - tiles["R"].x * Tile.size;
            
            if (overflow > 0) {
                this.x -= overflow;
            }
        }

        if (tiles["B"] != undefined && !tiles["B"].passable) {
            let overflow = this.y + 0.5 * this.size - tiles["B"].y * Tile.size;
            
            if (overflow > 0) {
                this.y -= overflow;
            }
        }
        rect(tiles["L"].x * Tile.size + Tile.size, 0, -10, 3000);
        if (tiles["L"] != undefined && !tiles["L"].passable) {
            let overflow = (tiles["L"].x +1) * Tile.size - (this.x - 0.5 * this.size);

            
            if (overflow > 0) {
                this.x += overflow;
            }
        }

        if (tiles["T"] != undefined && !tiles["T"].passable) {
            let overflow =(1+tiles["T"].y) * Tile.size - this.y + 0.5 * this.size;
            
            if (overflow > 0) {
                this.y += overflow;
            }
        }
    }
}