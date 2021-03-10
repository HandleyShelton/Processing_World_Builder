class Lava
{
  Body body;
  float r;
  Vec2 pos;
  
   color Color = #861200;

  Lava(float x, float y) {
    r = 3;
    makeLavaBody(new Vec2(x, y), r);
  }
  
  
  void col()
  {
    Color = #817D78;
  }
  
  void render() {
    pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(Color);
    noStroke();
    circle(0, 0, r);
    popMatrix();
  }

  void makeLavaBody(Vec2 center, float r_) {

    // Define a Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r_/2);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    // Parameters
    fd.friction = 0;
    fd.density = 2;
    fd.restitution = 0.7;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);


    body.setLinearVelocity(new Vec2(random(-5, 10), random(2, 10)));
    body.setAngularVelocity(random(-5, 10));
    body.setUserData(this);
  }
  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }
}
