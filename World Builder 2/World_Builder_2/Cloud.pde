class Cloud
{
  Body body;
  float r;
  boolean delete = false;
  
  Cloud(float x, float y) {
    r = 3;
    makeCloudBody(new Vec2(x, y), r);
  }
  
  void render() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(#C1C1C1);
    noStroke();
    circle(0, 0, r);
    popMatrix();
  }

  void makeCloudBody(Vec2 center, float r_) {

    // Define a Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r_/2);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    // Parameters
    fd.density = -1;
    fd.friction = 0;
    fd.restitution = 0.7;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);


    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
    body.setUserData(this);
  }
  void applyForce(Vec2 v) {
    body.applyForce(v, body.getWorldCenter());
  }
}
