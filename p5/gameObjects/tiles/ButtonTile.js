class ButtonTile extends WalkTile {


    constructor(x, y, color, playState) {
        super(x, y, color, true);
        this.playState = playState;
    }

    draw() {
        super.draw();
        const imgName = this.standingOn ? "buttonPressedTile" : "buttonTile";
        tint("#" + this.color);
        image(IMG[imgName], this.x * Tile.size, this.y * Tile.size + Tile.size * 0.1, Tile.size * 0.9, Tile.size * 0.9);
        noTint();
    }

    onPlayerEnter() {
        super.onPlayerEnter();

        for (let x = 0; x < this.playState.tiles.length; x++){
            for (let y = 0; y < this.playState.tiles[x].length; y++){
                const currentTile = this.playState.tiles[x][y];

                if (currentTile instanceof DoorTile && currentTile.color == this.color ) {
                    currentTile.passable = !currentTile.passable;
                }

            }
        }
    }
}