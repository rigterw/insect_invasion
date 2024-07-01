class FinishTile extends WalkTile {
    constructor(posX, posY, color,playState) {
        super(posX, posY, color, false, true);

        this.playState = playState;
    }
    
    draw() {
        super.draw();
        image(IMG["finishTile"], this.x * Tile.size, this.y * Tile.size, Tile.size, Tile.size);
    }

    onPlayerEnter() {

        //TODO: save score
        if (this.playState.tutorial) {
            if (this.playState.currentLvl >= this.playState.nLevels) {
                this.playState.tutorial = false;
            }
            else {
                this.playState.loadLevel(this.playState.currentLvl + 1);
                return;
            }
        }

        let nextMap;

        do {
            nextMap = Math.floor(random(this.playState.nLevels));
        } while (nextMap == this.playState.currentLvl);

        this.playState.loadLevel(nextMap);
    }
}