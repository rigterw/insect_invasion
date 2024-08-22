class ShopItem extends GameObject {

    static width = 140;
    static height = 200;
    selected = false;
    bought = false;
        
    constructor(x, y, img, price) {
        super();
        this.x = x;
        this.y = y;
        this.img = img;
        this.price = price;

        this.bought = price < 0;
    }

    draw() {
        fill(this.selected ? 255 : 0);
        stroke(this.selected ? 255 : 0);
        rect(this.x, this.y, ShopItem.width, ShopItem.height);
        if (this.img == Player.imgName) {
            fill(255, 200, 0);
        }
        else if(!this.bought && this.price > coins) {
            fill(100);
        } else if (!this.bought) {
            fill(100, 50, 250);
        }
        else {
            fill(75, 25, 150);
        }
        rect(this.x + 1, this.y + 1, ShopItem.width - 2, ShopItem.height - 2);

        fill(200);
        circle(this.x + ShopItem.width / 2, this.y + ShopItem.height / 2 - 40, 100);
        imageMode(CENTER);
        image(IMG[this.img], this.x + ShopItem.width / 2, this.y + ShopItem.height / 2 - 40, 60, 60);
        imageMode(CORNER);
        fill(255);
        let textt;
        textSize(23);
        textFont("text", 23);
        if (!this.bought) {
            textAlign(RIGHT);
            textt = this.price;
            image(IMG["coin"], this.x + ShopItem.width / 1.5, this.y + ShopItem.height - 45);
        } else {
            textAlign(CENTER);
            textt = this.img == Player.imgName ? "SELECTED" : "bought";
        }

        text(textt, this.x + ShopItem.width / 2, this.y + ShopItem.height - 20);
    }

    select() {
        console.log("dd");
        if (!this.bought) {
            if (coins < this.price) {
                return;
            }

            this.bought = true;
            coins -= this.price;
        }

        Player.imgName = this.img;
    }
}