class Grass
{
  Body body;
  float r;
  
  boolean delete = false;

  Grass(float x, float y) {
    r = 4;
    makeGrassBody(new Vec2(x, y), r);
  }
  
    void killBody() {
    box2d.destroyBody(body);
  }

  void delete() {
    delete = true;
  }
  
    boolean done() {
    if (delete) {
      killBody();
      return true;
    }
    return false;
  }

  void render() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(#6CA534);
    noStroke();
    circle(0, 0, r);
    popMatrix();
  }

  void makeGrassBody(Vec2 center, float r_) {

    // Define a Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r_/2);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    // Parameters
    fd.density = 10;
    fd.friction = 1;
    fd.restitution = 0.9;



    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);


    body.setLinearVelocity(new Vec2(random(-1, 1), random(1, 1)));
    body.setAngularVelocity(random(-1, 1));
    body.setUserData(this);
  }
}
