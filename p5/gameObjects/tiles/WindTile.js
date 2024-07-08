class WindTile extends Tile {

    static windSpeed = 10;
    constructor(x, y, color) {
        super(x, y, color, "wallTile", false);
        this.first = true;
    }

    draw() {
        super.draw();
        image(getAnim("windTile", 10), this.x * Tile.size, this.y * Tile.size, Tile.size, Tile.size);
    }

    update() {
        if (this.first) {
            this.updateWind();
            this.first = false;
        }
    }

    updateWind() {
        let nb = this.getNeighbours();

        this.setWind(nb["R"], "R");
        this.setWind(nb["L"], "L");
        this.setWind(nb["T"], "T");
        this.setWind(nb["B"], "B");

    }

    setWind(tile, windDir, isActive = true) {
        if (tile instanceof WalkableTile && tile.windDir != undefined) {
            if (tile.passable && isActive) {
                tile.windDir = windDir;
            } else {
                tile.windDir = "";
            }
            this.setWind(tile.getNeighbours()[windDir], windDir, tile.windDir != "");
        }
    }
}