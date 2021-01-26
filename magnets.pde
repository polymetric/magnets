final float PI_23RDS = PI * 2 / 3;

final int statorPoles = 6;
final int rotorPoles = 2;

long iter = 0;

ArrayList<Magnet> magnets = new ArrayList<Magnet>();
ArrayList<Magnet> rotorMagnets = new ArrayList<Magnet>();

float frictionCoefficient = 0.90;

void spawnMagnets() {
  magnets.clear();
  rotorMagnets.clear();
  
  //magnets.add(new Magnet(width/2, height/2 - 50, 1));
  //magnets.get(0).fixed = true;
  //magnets.add(new Magnet(width/2+50, 150, 1));
  
  for (int i = 0; i < statorPoles; i++) {
    Magnet m = new Magnet(0, 0, 0);
    m.angle = PI * 2 / statorPoles * i;
    m.pos.x = -sin(m.angle) * 200 + width/2;
    m.pos.y = cos(m.angle) * 200 + height/2;
    m.enabled = true;
    m.fixed = true;
    magnets.add(m);
  }
  
  for (int i = 0; i < rotorPoles; i++) {
    Magnet m = new Magnet(0, 0, 10);
    m.angle = PI * 2 / rotorPoles * i;
    m.pos.x = sin(m.angle) * 100 + width/2;
    m.pos.y = -cos(m.angle) * 100 + height/2;
    m.enabled = true;
    m.fixed = false;
    m.constrainRotation = true;
    magnets.add(m);
    rotorMagnets.add(m);
  }
  
  //rotorMagnets.get(0).vel.x = 1;
  //rotorMagnets.get(1).vel.x = -1;
  
  //m = new Magnet(width/2, height/2 + 50, 100);
  //m.enabled = true;
  ////m.fixed = true;
  //m.constrainRotation = true;
  //magnets.add(m);
}

Magnet m;

void setup() {
  size(500, 500);
  smooth(8);
  
  spawnMagnets();
}

void keyPressed() {
  if (key == 'r') {
    spawnMagnets();
  }
  if (key == 'b') {
    for (Magnet m : magnets) {
      m.enabled = !m.enabled;
      println(m.enabled);
    }
  }
  if (key == 'p') {
    temptest = (temptest + 1) % 3;
  }
}

float statorfield = 0;
float rotorpos = 0;

int temptest = 0;

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
  //magnets.get(0).angle = -atan2(mouseX-magnets.get(0).pos.x, mouseY-magnets.get(0).pos.y);
  
  //System.out.printf("rotor angle: %12.6f \t stator angle: %12.6f\n", magnets.get(0).angle, magnets.get(1).angle);
  
  rotorpos = rotorMagnets.get(0).angle / 2 + (PI / 2);
  
  for (int i = 0; i < statorPoles; i += 3) {
    //magnets.get(i).strength = sin(statorfield);
    //magnets.get(i+1).strength = sin(statorfield + PI_23RDS);
    //magnets.get(i+2).strength = sin(statorfield + PI_23RDS * 2);
    magnets.get(i).strength = sin(rotorpos);
    magnets.get(i+1).strength = sin(rotorpos + PI_23RDS);
    magnets.get(i+2).strength = sin(rotorpos + PI_23RDS * 2);
  }
  
  //switch (temptest) {
  //  case 0:
  //    for (int i = 0; i < statorPoles; i += 3) {
  //      magnets.get(i).strength = 1;
  //      magnets.get(i+1).strength = 0;
  //      magnets.get(i+2).strength = 0;
  //    }
  //    break;
  //  case 1:
  //    for (int i = 0; i < statorPoles; i += 3) {
  //      magnets.get(i).strength = 0;
  //      magnets.get(i+1).strength = 1;
  //      magnets.get(i+2).strength = 0;
  //    }
  //    break;
  //  case 2:
  //    for (int i = 0; i < statorPoles; i += 3) {
  //      magnets.get(i).strength = 0;
  //      magnets.get(i+1).strength = 0;
  //      magnets.get(i+2).strength = 1;
  //    }
  //    break;
  //}
  
  // debug temp
  System.out.printf("%6.6f %6.6f %6.6f %6.6f %6.6f\n", rotorMagnets.get(0).pos.x, rotorMagnets.get(0).pos.y, rotorMagnets.get(0).vel.x, rotorMagnets.get(0).vel.y, rotorMagnets.get(0).angle);
  
  statorfield += 0.01;
  
  //magnets.get(0).pos.x = 100 * sin(temp) + 250;
  //magnets.get(0).pos.y = 100 * cos(temp) + 250;
  //temp += 0.01;
  
  iter += 1;
}
