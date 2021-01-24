class Magnet {
  boolean enabled;
  boolean fixed;
  float strength;
  float angle;
  PVector pos;
  PVector vel;
  
  ForceArrow arrow;
  
  boolean constrainRotation;
  float constrainRadius;
  
  public Magnet(float x, float y, float strength) {
    enabled = true;
    fixed = false;
    pos = new PVector();
    vel = new PVector();
    pos.x = x;
    pos.y = y;
    vel.x = 0;
    vel.y = 0;
    this.strength = strength;
    
    arrow = new ForceArrow();
    
    constrainRotation = false;
    constrainRadius = 100;
  }
  
  public void tick() {
    if (!fixed) {
      pos.add(vel);
      vel.mult(frictionCoefficient);
      
      arrow.origin = pos.copy();
      arrow.force = vel.copy();
    }
    
    if (constrainRotation) {
      // constrain distance
      PVector radiusLine = pos.copy();
      
      radiusLine.sub(width/2, height/2);
      radiusLine.normalize();
      radiusLine.mult(constrainRadius);
      
      pos.x = width/2 + radiusLine.x;
      pos.y = height/2 + radiusLine.y;
      
      stroke(232);
      strokeWeight(1);
      line(width/2, height/2, pos.x, pos.y);
      
      // always face center
      angle = -atan2(pos.x-width/2, pos.y-height/2);
    }
  }
  
  public void draw() {
    stroke(224);
    strokeWeight(10);
    PVector a, b, c;
    a = pos.copy();
    b = pos.copy();
    c = new PVector(0, 20);
    c.rotate(angle);
    a.add(c);
    b.sub(c);
    line(a.x, a.y, b.x, b.y);
    stroke(224, 32, 32);
    point(a.x, a.y);
    stroke(32, 32, 224);
    point(b.x, b.y);
  }
  
  public void attract(Magnet other) {
    arrow.enabled = this.enabled;
    if (!enabled) return;
    
    if (!fixed) {
      PVector diff = other.pos.copy();
      float dist = pos.dist(other.pos);
      diff.sub(pos);
      diff.normalize();
      diff.mult(cos(angle) * cos(other.angle) * strength * other.strength);
      //diff.div(dist * dist);
      //diff.div(1000);
      diff.mult(100);
      
      vel.add(diff);
    } else {
      PVector arrowvec = new PVector();
      arrowvec.x = sin(angle) * strength;
      arrowvec.y = -cos(angle) * strength;
      arrowvec.mult(2);
      
      arrow.origin = pos.copy();
      arrow.force = arrowvec.copy();
    }
  }
}
