class ForceArrow {
  PVector origin;
  PVector force;
  
  public ForceArrow() {
    
  }
  
  public void draw() {
    stroke(224, 32, 32);
    strokeWeight(1);
    
    // line
    PVector a, b, c;
    a = origin.copy();
    b = origin.copy();
    c = force.copy();
    c.mult(800);
    b.add(c);
    line(a.x, a.y, b.x, b.y);
    
    // arrow head
    PVector d, e;
    d = b.copy();
    e = b.copy();
    
    //c.normalize();
    c.div(5);
    
    c.rotate(PI/4 * 3);
    d.add(c);
    
    c.rotate(PI/2);
    e.add(c);
    
    line(b.x, b.y, d.x, d.y);
    line(b.x, b.y, e.x, e.y);
  }
}
