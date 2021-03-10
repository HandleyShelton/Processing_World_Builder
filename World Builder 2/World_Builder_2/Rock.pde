class Rock
{
  Body body;
  float r;

  Rock(float x, float y) {
    r = 5;
    makeRockBody(new Vec2(x, y), r);
  }

  void killBody() {
    box2d.destroyBody(body);
  }


  boolean done() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+r) {
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
    fill(#817D78);
    noStroke();
    circle(0, 0, r);
    popMatrix();
  }

  void makeRockBody(Vec2 center, float r_) {

    // Define a Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r_/2);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    // Parameters
    fd.density = 20;
    fd.friction = 1;
    fd.restitution = 0;


    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);


    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
    body.setUserData(this);
  }
}
