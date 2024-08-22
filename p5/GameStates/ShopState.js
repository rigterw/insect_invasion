class ShopState extends GameState {

    shopItems = [];
    x = 0;
    y = 0;
    constructor() {
        super();

        this.shopItems.push([]);
        this.shopItems.push([]);

        this.shopItems[0].push(this.makeShopItem(120, 60, "player", -1));
        this.shopItems[0].push(this.makeShopItem(420, 60, "player1", 10));
        this.shopItems[0].push(this.makeShopItem(720, 60, "player2", 25));
        this.shopItems[0].push(this.makeShopItem(1020, 60, "player3", 50));
        this.shopItems[1].push(this.makeShopItem(270, 320, "player4", 75));
        this.shopItems[1].push(this.makeShopItem(570, 320, "player5", 100));
        this.shopItems[1].push(this.makeShopItem(870, 320, "player6", 200));

        this.navigate(0, 0);
    }

    makeShopItem(x, y, name, price, purchased) {
        const item = new ShopItem(x, y, name, price, purchased);
        this.visibleObjects.push(item);
        return item;
    }

    handleInput(pressed) {
        if (!pressed) {
            return;
        }

        switch (keyCode) {
            case (65):
                this.navigate(-1, 0);
                break;
            case (68):
                this.navigate(1, 0);
                break;
            case (83):
                this.navigate(0, -1);
                break;
            case (87):
                this.navigate(0,-1);
                break;
            
            case (32):
                this.shopItems[this.y][this.x].select();
            case (82):
                gameStateManager.switchState("PlayState");
                break;
        }
    }

    navigate(x, y) {
        this.shopItems[this.y][this.x].selected = false;
        
        if (y != 0) {
            this.y = this.y == 0 ? 1 : 0;
            if (this.x >= this.shopItems[this.y].length) {
                this.x = this.shopItems[this.y].length - 1;
            }
        } else {
            this.x += x;

            if (this.x >= this.shopItems[this.y].length) {
                this.x = 0;
            }
            else if (this.x <= -1) {
                this.x = this.shopItems[this.y].length - 1;
            }
        }
        this.shopItems[this.y][this.x].selected = true;

    }
}