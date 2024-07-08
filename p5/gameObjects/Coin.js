class Coin extends GameObject {

    active = true;
    static width = 26;
    static height = 32;
    constructor(posX, posY) {
        super();
        this.x = (posX + 0.5) * Tile.size;
        this.y = (posY + 0.5) * Tile.size;
    }

    pickup() {
        PlayState.instance.timer.time += Timer.timeValue;
        coins++;
        this.active = false;
        SOUND["coin"].play();
    }

    update() {
        if (this.active && dist(PlayState.instance.player.x, PlayState.instance.player.y, this.x, this.y) < (PlayState.instance.player.size + Coin.height) / 2) {
            this.pickup();
        }
    }

    draw() {
        if (!this.active) {
            return;
        }

        image(IMG["coin"], this.x - Coin.width / 2, this.y - Coin.height / 2, Coin.width, Coin.height);
    }
}