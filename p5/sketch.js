let gameStateManager;

const img = new Object();
const font = new Object();
function setup() {
    ellipseMode(CENTER);
    textAlign(CENTER);
    createCanvas(1000, 750, document.getElementById("game"));
    //game settings
    load();
}

//creates all the objects after the settings are initialized
function load() {
    loadTxtFont("text", "Font.ttf");
    
    gameStateManager = new GameStateManager();
}


function loadImg(imgName, fileName) {
    img[imgName] = loadImage("./img/" + fileName);
}

function loadTxtFont(fontName, fileName) {
    font[fontName] = loadFont("./font/" + fileName);
}
function draw() {
    background("#8CC43C");
    gameStateManager.draw();
}

function mousePressed() {
    if (mouseButton === LEFT) {
        gameStateManager.click(createVector(mouseX, mouseY));
    } else if (mouseButton === RIGHT) {
        gameStateManager.rclick(createVector(mouseX, mouseY));
    }
}


function delay(milliseconds){
    return new Promise(resolve => {
        setTimeout(resolve, milliseconds);
    });
}

function createArray(xSize,ySize) {
    const array = new Array(xSize);
    for (let x = 0; x < xSize; x++){
        array[x] = new Array(ySize);
    }

    return array;
}
