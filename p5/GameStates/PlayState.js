class PlayState extends GameState {

    nLevels = 6;
    constructor() {
        super();
        this.LoadLevel(0);
    }

    LoadLevel(id) {

        const levelImg = img[`level${id}`];
        const levelOverlay = img[`level${id}O`]
        color(0, 0, 0);
        fill(255, 165, 0);
        rect(10, 10, 18, 18);

        image(levelImg, 0, 0);
        image(levelOverlay, levelImg.width, 0);

        this.tiles = createArray(levelImg.width, levelImg.height);
        
        for (let x = 0; x < levelImg.width; x++){
            for (let y = 0; y < levelImg.height; y++){
                let tile = null;
                
                const color = hex(levelImg.get(x, y));
                let colorHex = color[0].slice(-2) + color[1].slice(-2) + color[2].slice(-2);
                if(x == 3 && y == 4)
                console.log(colorHex);
                switch (colorHex) {
                    case "CE7C38":
                        tile = new WalkTile(x, y, "");
                        break;
                    default:
                        tile = new GrassTile(x, y, "#000000");
                }
                if (tile != null) {   
                    this.tiles[x, y] = tile;
                    this.visibleObjects.push(tile);
                }


            }
        }
    }
}