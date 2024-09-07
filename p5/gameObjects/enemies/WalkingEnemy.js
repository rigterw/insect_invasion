class WalkingEnemy extends Enemy {
    static dirTranslation = {
        '0,-1': ['T', 'L', 'R', 'B'],
        '0,0': ['T', 'L', 'R', 'B'],
        '-1,0': ['L', 'B', 'T', 'R'],
        '0,1': ['B', 'R', 'L', 'T'],
        '1,0': ['R', 'T', 'B', 'L']
    };

    goal;
    constructor(posX, posY, currentTile) {
        super(posX, posY);
        this.setGoal(currentTile);
    }

    setGoal(prevGoal) {
        let nb = prevGoal.getNeighbours();
        let dirs = WalkingEnemy.dirTranslation[`${this.vX},${this.vY}`];

        let score = this.getPassLikeness(nb[dirs[0]]);
        let dir = 0;

        if (score < 3) {
            for (let i = 1; i < 3; i++) {//this doesn't check if it should turn around
                let newScore = this.getPassLikeness(nb[dirs[i]]);
                if (score < newScore) {
                    dir = i;
                    score = newScore;
                }
            }
        }
        //turn around
        if (score == 0)
            dir = 3;

        switch (dirs[dir]) {
            case "T":
                this.vX = 0;
                this.vY = -1;

                break;
            case "L":
                this.vX = -1;
                this.vY = 0;
                break;
            case "R":
                this.vX = 1;
                this.vY = 0;
                break;
            case "B":
                this.vX = 0;
                this.vY = 1;
                break;
        }
        this.currentTile = nb[dirs[dir]];
    }

    update() {
        super.update();
        this.checkUpdate();
    }

    checkUpdate() {
        let distance;
        switch (`${this.vX},${this.vY}`) {
            case "1,0":
                distance = (this.currentTile.x + 0.5) * Tile.size - this.x;
                break;
            case "-1,0":
                distance = this.x - (this.currentTile.x + 0.5) * Tile.size;
                break;

            case "0,1":
                distance = (this.currentTile.y + 0.5) * Tile.size - this.y;
                break;
            case "0,-1":
                distance = this.y - (this.currentTile.y + 0.5) * Tile.size;
                break;
        }
        if (distance <= 0) {
            this.setGoal(this.currentTile);
        }
    }

    getPassLikeness(tile) {
        if (tile instanceof OneWayTile) {
            return tile.canPass(this.x, this.y) ? 1 : 0;
        }
        if (tile instanceof EnemyWalkTile) {
            return tile.unWanted ? 1 : 3;
        }
        if (tile instanceof DoorTile && tile.passable) {
            return 2;
        }
        if (tile instanceof ButtonTile) {
            return 1;
        }

        return 0;
    }
}