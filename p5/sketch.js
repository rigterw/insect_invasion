let gameStateManager;

let nLevels = 7;
let frameCounter = 0;
let coins = 0;
let score = 0;

const IMG = new Object();
const font = new Object();
const ANIM = new Object();
const SOUND = new Object();

function setup() {
    ellipseMode(CENTER);
    textAlign(CENTER, CENTER);
    createCanvas(1280, 720, document.getElementById("game"));
    //game settings
    load();

    SOUND["music"].loop();
}

function preload() {
    loadImg("startScreen", "startScreen");
    loadTxtFont("text", "Font.ttf");

    for (let i = 0; i < nLevels; i++){
        loadImg(`level${i}`, `levels/level${i}`);
        loadImg(`level${i}O`, `levels/level${i}overlay`);
    }

    for (let i = 0; i < 20; i++){
        loadImg(`grassTile${i}`, `tiles/GrassTile${i}`);
    }

    for (let i = 0; i < 4; i++){
        loadImg(`walkTile${i}`, `tiles/WalkTile${i}`);
    }

    loadImg("buttonTile", `tiles/ButtonTile`);
    loadImg("buttonPressedTile", `tiles/ButtonPressed`);
    loadImg("doorTile", `tiles/DoorTile`);
    loadImg("doorOpenTile", `tiles/DoorOpenTile`);
    loadImg("finishTile", `tiles/finishTile`);
    loadImg("oneWayTile", `tiles/oneWayTile`);
    loadImg("wallTile", "tiles/wallTile");
    loadAnim("wind", "tiles/wind/wind", 9);
    loadAnim("windTile", "tiles/windTile/fan", 2);

    loadImg("player", "player/player");
    loadImg("enemy", "enemy/ant");
    loadImg("coin", "coin");

    loadAnim("playerWalk", 'player/playerWalk', 2);
    loadAnim("enemyWalk", 'enemy/EnemyWalk', 2);

    loadAudio("coin", "coin");
    loadAudio("finish", "finish");
    loadAudio("button", "button");
    loadAudio("click", "click");
    loadAudio("music", "soundtrack");
}

//creates all the objects after the settings are initialized
function load() {
    gameStateManager = new GameStateManager();
}


function loadImg(imgName, fileName) {
    IMG[imgName] = loadImage("./img/" + fileName + ".png");
}

function loadAudio(soundName, fileName) {
    SOUND[soundName] = loadSound(`./sounds/${fileName}.wav`);
}

function loadTxtFont(fontName, fileName) {
    font[fontName] = loadFont("./font/" + fileName);
}

function loadAnim(animName, fileName, nFrames) {
    frames = [];
    for (let i = 0; i < nFrames; i++){
        frames.push(loadImage(`./img/${fileName}${i}.png`));
    }

    ANIM[animName] = frames;
}

function getAnim(animName, speed = 1) {
    let animFrame = Math.floor(frameCounter / speed);
    let animation = ANIM[animName];
    return animation[animFrame % animation.length];
}

function draw() {
    background("#8CC43C");
    gameStateManager.draw();
    frameCounter++;
}

function createArray(xSize,ySize) {
    const array = new Array(xSize);
    for (let x = 0; x < xSize; x++){
        array[x] = new Array(ySize);
    }

    return array;
}

function keyPressed() {
    gameStateManager.handleInput(true);
}

function keyReleased() {
    gameStateManager.handleInput(false);
}
