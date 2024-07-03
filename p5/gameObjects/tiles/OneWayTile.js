class OneWayTile extends WalkTile {
    constructor(posX, posY, color) {
        super(posX, posY, color);
    }

    draw() {
        super.draw();
        push();
        translate((this.x + 0.5) * Tile.size, (this.y + 0.5 ) * Tile.size);
        
        imageMode(CENTER);
        let rotation;

        switch (this.color) {
            case "FF0000":
                rotation = -0.5 * PI;
                break;
            case "00FF21":
                rotation = 0;
                break;
            case "0026FF":
                rotation = 0.5 * PI;
                break;
            case "FFFFFF":
                rotation = PI;
                break;
        }
        rotate(rotation);
        image(IMG["oneWayTile"], 0, 0, Tile.size, Tile.size);
        pop();
    }

    update() {
        let p = PlayState.instance.player;
        switch (this.color) {
            case "FF0000":
                this.passable = p.y > this.y * Tile.size;

                break;
            case "00FF21":
                this.passable = p.x < (1 + this.x) * Tile.size;
                break;
            case "0026FF":
                this.passable = p.y < (1 + this.y) * Tile.size;

                break;
            case "FFFFFF":
                this.passable = p.x > this.x * Tile.size;
                break;
        }
    }
}