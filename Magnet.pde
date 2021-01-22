class Magnet {
  boolean enabled;
  boolean fixed;
  float strength;
  float angle;
  PVector pos;
  PVector vel;
  
  ForceArrow arrow = new ForceArrow();
  
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
  }
  
  public void tick() {
    if (!fixed) {
      pos.add(vel);
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
  }
  
  public void attract(Magnet other) {
    PVector diff = other.pos.copy();
    float dist = pos.dist(other.pos);
    diff.sub(pos);
    diff.normalize();
    diff.mult(cos(angle) * cos(other.angle) * strength * other.strength);
    diff.div(dist * dist);
    //diff.div(1000);
    diff.mult(1000);
    
    vel.add(diff);
    arrow.origin = pos.copy();
    arrow.force = diff.copy();
  }
}
