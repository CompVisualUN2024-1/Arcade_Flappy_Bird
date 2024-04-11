// Declaración de variables para el pájaro, los tubos, el estado del juego y el puntaje.
int birdY, birdSpeed, gravity;
int gap, tubeWidth, tubeSpeed;
int tubeX, topTubeHeight, bottomTubeHeight;
boolean gameover;
int score;

void setup() {
  // Configuración inicial del lienzo de juego.
  size(400, 600);
  // Iniciar el juego.
  startGame();
}

void draw() {
  // Fondo del lienzo.
  background(0);
  
  // Si el juego no ha terminado, actualiza y dibuja el juego.
  if (!gameover) {
    moveBird();
    moveTubes();
    checkCollisions();
    drawBird();
    drawTubes();
    drawScore();
  } else { // Si el juego ha terminado, muestra el mensaje de Game Over.
    displayGameOver();
  }
}

// Función para manejar las teclas presionadas.
void keyPressed() {
  // Si el juego ha terminado y se presiona la flecha hacia arriba, reinicia el juego.
  if (keyCode == UP && gameover) {
    startGame();
  } else if (keyCode == ' ' && !gameover) { // Si se presiona la barra espaciadora y el juego no ha terminado, el pájaro salta.
    birdSpeed = -15;
  }
}

// Función para iniciar el juego.
void startGame() {
  // Configuración inicial de todas las variables del juego.
  birdY = height/2;
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

// Función para mover al pájaro.
void moveBird() {
  birdSpeed += gravity;
  birdY += birdSpeed;
}

// Función para dibujar al pájaro.
void drawBird() {
  fill(255, 255, 0);
  ellipse(100, birdY, 50, 50);
}

// Función para mover los tubos.
void moveTubes() {
  tubeX -= tubeSpeed;
  // Si un tubo sale del lienzo, se genera un nuevo conjunto de tubos y se incrementa el puntaje.
  if (tubeX < -tubeWidth) {
    tubeX = width;
    topTubeHeight = int(random(50, height - gap - 50));
    bottomTubeHeight = height - topTubeHeight - gap;
    score++;
  }
}

// Función para dibujar los tubos.
void drawTubes() {
  fill(0, 255, 0);
  rect(tubeX, 0, tubeWidth, topTubeHeight);
  rect(tubeX, height - bottomTubeHeight, tubeWidth, bottomTubeHeight);
}

// Función para verificar colisiones.
void checkCollisions() {
  // Si el pájaro colisiona con los límites del lienzo o con los tubos, el juego termina.
  if (birdY < 0 || birdY > height || 
      (100 + 25 > tubeX && 100 - 25 < tubeX + tubeWidth && 
       (birdY - 25 < topTubeHeight || birdY + 25 > height - bottomTubeHeight))) {
    gameover = true;
  }
}

// Función para dibujar el puntaje en la pantalla.
void drawScore() {
  fill(255);
  textSize(32);
  text(score, width/2, 50);
}

// Función para mostrar el mensaje de Game Over.
void displayGameOver() {
  fill(255);
  textSize(32);
  text("Game Over", width/2 - 100, height/2);
  text("Score: " + score, width/2 - 80, height/2 + 50);
  text("Presiona flecha arriba para reiniciar", width/2 - 200, height/2 + 100);
}
   
