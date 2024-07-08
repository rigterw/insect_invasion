class FinishTile extends WalkTile {
    constructor(posX, posY, color) {
        super(posX, posY, color);
    }
    
    draw() {
        super.draw();
        image(IMG["finishTile"], this.x * Tile.size, this.y * Tile.size, Tile.size, Tile.size);
    }

    onPlayerEnter() {

        //TODO: save score
        if (PlayState.instance.tutorial) {
            if (PlayState.instance.currentLvl >= PlayState.instance.nLevels) {
                PlayState.instance.tutorial = false;
            }
            else {
                PlayState.instance.loadLevel(PlayState.instance.currentLvl + 1);
                return;
            }
        }

        let nextMap;

        do {
            nextMap = Math.floor(random(PlayState.instance.nLevels));
        } while (nextMap == PlayState.instance.currentLvl);

        PlayState.instance.loadLevel(nextMap);
    }
}