// Declaración de variables para el pájaro, los tubos, el estado del juego y el puntaje.
int birdY, birdSpeed, gravity;
int gap, tubeWidth, tubeSpeed;
int tubeX, topTubeHeight, bottomTubeHeight;
boolean gameover;
int score;
int highScore = 0;

PImage birdImg;
PImage topTubeImg, bottomTubeImg;
PImage backgroundImg;
boolean paused = false;

void setup() {
  size(400, 600);

  // Cargar las imágenes (asegúrate de tener los archivos de imagen en la misma carpeta que tu sketch).
  birdImg = loadImage("bird.png"); // Carga la imagen del pájaro.
  topTubeImg = loadImage("top_tube.png"); // Carga la imagen del tubo superior.
  bottomTubeImg = loadImage("bottom_tube.png"); // Carga la imagen del tubo inferior.
  backgroundImg = loadImage("background.jpeg"); // Carga la imagen del fondo.

  // Verificar si las imágenes se cargaron correctamente.
  if (birdImg == null || topTubeImg == null || bottomTubeImg == null || backgroundImg == null) {
    println("Error: No se pudo cargar alguna imagen. Se utilizarán figuras básicas.");
  }

  startGame();
}

void draw() {
  // Fondo del lienzo con imagen.
  if (backgroundImg != null) {
    drawBackground();
  } else {
    background(0);
  }

  if (!gameover &&!paused) {
    moveBird();
    moveTubes();
    checkCollisions();
    if (birdImg != null) {
      drawBird();
    } else {
      drawDefaultBird();
    }
    if (topTubeImg != null && bottomTubeImg != null) {
      drawTubes();
    } else {
      drawDefaultTubes();
    }
    drawScore();
  } else if (paused) {
    fill(255);
    textSize(32);
    text("Pausa", width / 2 - 50, height / 2);
  } else {
    displayGameOver();
  }
}

void keyPressed() {
  if (keyCode == UP && gameover) {
    startGame();
  } else if (keyCode == ' ' && !gameover &&!paused) {
    birdSpeed = -15;
    // jumpSound.play(); // Reproducir sonido de salto.
  } else if (key == 'p' || key == 'P') {
    paused =!paused; // Toggle pausa
  }
}

void startGame() {
  birdY = height / 2;
  birdSpeed = 0;
  gravity = 1;
  gap = 200;
  tubeWidth = 80;
  tubeSpeed = 3;
  tubeX = width;
  topTubeHeight = int(random(50, height - gap - 50));
  bottomTubeHeight = height - topTubeHeight - gap;
  gameover = false;
  score = 0;
}

void moveBird() {
  birdSpeed += gravity;
  birdY += birdSpeed;
}

void drawBird() {
  image(birdImg, 75, birdY, 100, 100); // Dibuja la imagen del pájaro.
}

void drawDefaultBird() {
  fill(255, 255, 0);
  ellipse(100, birdY, 50, 50); // Dibuja una elipse como pájaro por defecto.
}

void moveTubes() {
  tubeX -= tubeSpeed;
  if (tubeX < -tubeWidth) {
    tubeX = width;
    topTubeHeight = int(random(50, height - gap - 50));
    bottomTubeHeight = height - topTubeHeight - gap;
    score++;
    // pointSound.play(); // Reproducir sonido de punto.
  }
  if (score % 2 == 0 && score != 0) {
    tubeSpeed += 0.1;
  }
}

void drawTubes() {
  image(topTubeImg, tubeX, 0, tubeWidth, topTubeHeight+30); // Dibuja el tubo superior.
  image(bottomTubeImg, tubeX, height - bottomTubeHeight, tubeWidth, bottomTubeHeight+30); // Dibuja el tubo inferior.
}

void drawDefaultTubes() {
  fill(0, 255, 0);
  rect(tubeX, 0, tubeWidth, topTubeHeight);
  rect(tubeX, height - bottomTubeHeight, tubeWidth, bottomTubeHeight);
}

void checkCollisions() {
  if (birdY < 0 || birdY > height || 
      (100 + 25 > tubeX && 100 - 25 < tubeX + tubeWidth && 
       (birdY - 25 < topTubeHeight || birdY + 25 > height - bottomTubeHeight))) {
    gameover = true;
    // hitSound.play(); // Reproducir sonido de choque.
    if (score > highScore) {
      highScore = score;
    }
  }
}

void drawScore() {
  fill(255);
  textSize(32);
  text(score, width / 2, 50);
}

void drawBackground() {
  image(backgroundImg, 0, 0, width, height); // Dibuja la imagen del fondo.
}

void displayGameOver() {
  fill(255);
  textSize(32);
  text("Game Over", width / 2 - 100, height / 2);
  text("Score: " + score, width / 2 - 80, height / 2 + 50);
  text("High Score: " + highScore, width / 2 - 100, height / 2 + 100); // Mostrar el mejor puntaje.
  text("Presiona flecha arriba para reiniciar", width / 2 - 200, height / 2 + 150);
}
