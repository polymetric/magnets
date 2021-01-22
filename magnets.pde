ArrayList<Magnet> magnets = new ArrayList<Magnet>();

float frictionCoefficient = 0.97;

void spawnMagnets() {
  magnets.clear();
  
  magnets.add(new Magnet(width/2, height/2, 1));
  //magnets.get(0).fixed = true;
  magnets.add(new Magnet(width/2, 150, 1));
}

void setup() {
  size(500, 500);
  smooth(8);
  
  spawnMagnets();
}

void mouseClicked() {
  spawnMagnets();
}

float temp = 0;

void draw() {
  background(32);
  
  for (Magnet m : magnets) {
    m.draw();
    m.tick();
    for (Magnet m2 : magnets) {
      if (m != m2) {
        m.attract(m2);
      }
    }
    m.arrow.draw();
  }
  
  //magnets.get(0).angle += 0.01;
  magnets.get(0).angle = -atan2(mouseX-magnets.get(0).pos.x, mouseY-magnets.get(0).pos.y);
  
  System.out.printf("rotor angle: %12.6f \t stator angle: %12.6f\n", magnets.get(0).angle, magnets.get(1).angle);
  
  //magnets.get(0).pos.x = 100 * sin(temp) + 250;
  //magnets.get(0).pos.y = 100 * cos(temp) + 250;
  //temp += 0.01;
}
