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
        if (Playstate.instance.tutorial) {
            if (Playstate.instance.currentLvl >= Playstate.instance.nLevels) {
                Playstate.instance.tutorial = false;
            }
            else {
                Playstate.instance.loadLevel(Playstate.instance.currentLvl + 1);
                return;
            }
        }

        let nextMap;

        do {
            nextMap = Math.floor(random(Playstate.instance.nLevels));
        } while (nextMap == Playstate.instance.currentLvl);

        Playstate.instance.loadLevel(nextMap);
    }
}