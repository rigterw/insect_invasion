class WalkableTile extends Tile {

    standingOn = false;
    windDir = "";
    constructor(x, y, color, textureName, passable = true) {
        super(x, y, color, textureName, passable);
    }

    update() {
        super.update();

        if (this.standingOn && this.windDir != undefined && this.windDir != "") {

            const player = PlayState.instance.player;
            switch (this.windDir) {
                case "T":
                    player.y -= WindTile.windSpeed;
                    break;
                case "B":
                    player.y += WindTile.windSpeed;
                    break;
                case "L":
                    player.x -= WindTile.windSpeed;
                    break;
                case "R":
                    player.x += WindTile.windSpeed;
                    break;
            }
        }
    }
    onPlayerEnter() {
        this.standingOn = true;
     }
    onPlayerExit() {
        this.standingOn = false;
    }
}