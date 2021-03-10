class Base {

  float x;
  float y;
  float w;
  float h;

  Body body;

  Base(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Define shape
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);
    body.createFixture(sd, 1);
    body.setUserData(this);
  }

  void display() {
    //fill(0);
    //stroke(0);
    //rectMode(CENTER);
    //rect(x, y, w, h);
  }
}
