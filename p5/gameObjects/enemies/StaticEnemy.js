class StaticEnemy extends Enemy {
    chasing = false;
    constructor(posX, posY) {
        super(posX, posY);

        this.sX = posX;
        this.sY = posY;
        this.player = PlayState.instance.player;
        this.maxV /= 3;
        this.rotation = PI;
    }

    update() {
        this.vY = 0;
        if (this.player.x > this.sX - 0.5 * Tile.size && this.player.x < this.sX + 0.5 * Tile.size && this.player.y - this.y < 4 * Tile.size) {
            if (this.y - this.sY < Tile.size) {
                this.vY = this.maxV;
            }
        } else if (this.sY < this.y) {
            this.vY = - this.maxV;
        }
        super.update();
    }
}