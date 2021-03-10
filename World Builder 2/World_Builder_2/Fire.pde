class Fire
{
  Body body;
  float r;
  
  boolean cloud = false;
  
  float x;
  float y;
  
  int FireDestroyDelay;

  Fire(float x, float y) {
    r = 3;
    makeFireBody(new Vec2(x, y), r);
  }
  
    void killBody() {
    box2d.destroyBody(body);
  }

  void delete() {
    cloud = true;
  }
  
    boolean done() {
    if (cloud) {
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
    fill(#FF2D0D);
    noStroke();
    circle(0, 0, r);
    popMatrix();
    x = pos.x;
    y = pos.y;
  }

  void makeFireBody(Vec2 center, float r_) {

    // Define a Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r_/2);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    // Parameters
    fd.density = -1;
    fd.friction = 0;
    fd.restitution = 0.5;



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
