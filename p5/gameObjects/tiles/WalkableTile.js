class WalkableTile extends Tile {

    standingOn = false;
    constructor(x, y, color, textureName, passable = true) {
        super(x, y, color, textureName, passable);
    }
    onPlayerEnter() {
        this.standingOn = true;
     }
    onPlayerExit() {
        this.standingOn = false;
    }
}