import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
// Project by handley shelton
// This project requires box2d to run download it from within processing!



// Initilizes Variables
Box2DProcessing box2d;

PImage img;

ArrayList<Base> base;

ArrayList<Water> water;
boolean waterBool = false;

ArrayList<Rock> rock;
boolean rockBool = false;

ArrayList<Sand> sand;
boolean sandBool = false;

ArrayList<Grass> grass;
ArrayList<Grass> grassDestroy;
boolean grassBool = false;

ArrayList<Lava> lava;
boolean lavaBool = false;

ArrayList<Cloud> cloud;
boolean cloudBool = false;

ArrayList<Meteor> meteor;
boolean meteorBool = false;

ArrayList<Fire> fire;
boolean fireBool = false;

ArrayList<Oil> oil;
boolean oilBool = false;

String toolTip = "Tool: ";

int cloudTrack=1;
void setup() {
  size(500, 500);
  smooth();

  img = loadImage("BackGround.jpg");
  
//starts box2d systems

  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  box2d.listenForCollisions();

//Sets up Object Handling
  water = new ArrayList<Water>();
  base = new ArrayList<Base>();
  rock = new ArrayList<Rock>();
  sand = new ArrayList<Sand>();
  grass = new ArrayList<Grass>();
  grassDestroy = new ArrayList<Grass>();
  lava = new ArrayList<Lava>();
  cloud = new ArrayList<Cloud>();
  meteor = new ArrayList<Meteor>();
  fire = new ArrayList<Fire>();
  oil = new ArrayList<Oil>();

//Adds Base for levels
  base.add(new Base(width/2, height-17, 1280, 100));
  base.add(new Base(-5, height/2, 10, 720));
  base.add(new Base(width+5, height/2, 10, 720));
  base.add(new Base(20, 0, 1280, 10));
}

void draw() {
  background(255);
  image(img, 0, 0);
  
  //allows box2d to run
  box2d.step();
  
  //This displays walls
  for (Base wall : base) {
    wall.display();
  }
  //This moves the cloud and fire objects
  for (Cloud cc : cloud) {
    Vec2 wind = new Vec2(random(-10, 10), random(-1, 25));
    cc.applyForce(wind);
  }

  for (Fire f : fire) {
    Vec2 wind = new Vec2(random(-10, 10), random(-10, 27));
    f.applyForce(wind);
  }

  fill(000);

  text(toolTip, width-100, height-5);
  fill(#B9B9B9);
  text("Z to Restart", 10, 20);


  //This allows user to create diffrent objects
  if (mousePressed) {
    if (waterBool == true)
    {
      Water w = new Water(mouseX, mouseY);
      water.add(w);
      Water w1 = new Water(mouseX, mouseY);
      water.add(w1);
      Water w2 = new Water(mouseX, mouseY);
      water.add(w2);
    }
    if (fireBool == true)
    {
      Fire f = new Fire(mouseX, mouseY);
      fire.add(f);
    }
    if (rockBool == true)
    {
      Rock r = new Rock(mouseX, mouseY);
      rock.add(r);
      Rock r1 = new Rock(mouseX, mouseY);
      rock.add(r1);
      Rock r2 = new Rock(mouseX, mouseY);
      rock.add(r2);
    }
    if (sandBool == true)
    {
      Sand s = new Sand(mouseX, mouseY);
      sand.add(s);
      Sand s1 = new Sand(mouseX, mouseY);
      sand.add(s1);
      Sand s2 = new Sand(mouseX, mouseY);
      sand.add(s2);
    }
    if (grassBool == true)
    {
      Grass g = new Grass(mouseX, mouseY);
      grass.add(g);
      Grass g1 = new Grass(mouseX, mouseY);
      grass.add(g1);
      Grass g2 = new Grass(mouseX, mouseY);
      grass.add(g2);
    }
    if (lavaBool == true)
    {
      Lava l = new Lava(mouseX, mouseY);
      lava.add(l);
      Lava l1 = new Lava(mouseX, mouseY);
      lava.add(l1);
      Lava l2 = new Lava(mouseX, mouseY);
      lava.add(l2);
    }
    if (cloudBool == true)
    {
      Cloud c = new Cloud(mouseX, mouseY);
      cloud.add(c);
      Cloud c1 = new Cloud(mouseX, mouseY);
      cloud.add(c1);
    }
    if (meteorBool == true)
    {
      Meteor m = new Meteor(mouseX, mouseY);
      meteor.add(m);
    }
    if (oilBool == true)
    {
      Oil o = new Oil(mouseX, mouseY);
      oil.add(o);
    }
  }
  
  //Renders Objects and deleted thoes who need to be deleted
  for (Oil o : oil) {
    if (o.fire == true)
    {
      Fire ff = new Fire(o.x, o.y);
      fire.add(ff);
    }
    o.render();
  }

  for (Water w : water) {
    if (w.cloud == true && cloudTrack == 1)
    {
      Cloud c4 = new Cloud(w.x, w.y);
      cloud.add(c4);
      cloudTrack = 0;
    }
    w.render();
  }
  for (Rock r : rock) {
    r.render();
  }
  for (Sand s : sand) {
    s.render();
  }
    for (Lava l : lava) {
    l.render();
  }
  for (Cloud c : cloud) {
    c.render();
  }
  for (Meteor m : meteor) {
    m.render();
  }
  for (Fire f : fire) {
    f.render();
  }
  for (int i = grass.size()-1; i >= 0; i--) {
    Grass g = grass.get(i);
    g.render();
    if (g.done()) {
      grass.remove(i);
    }
  }
  for (int i = oil.size()-1; i >= 0; i--) {
    Oil o = oil.get(i);
    o.render();
    if (o.done()) {
      oil.remove(i);
    }
  }
  for (int i = water.size()-1; i >= 0; i--) {
    Water w = water.get(i);
    w.render();
    if (w.done()) {
      water.remove(i);
    }
  }
    for (int i = fire.size()-1; i >= 0; i--) {
    Fire fff = fire.get(i);
    fff.render();
    if (fff.done()) {
      fire.remove(i);
    }
  }
}

// Collision event function
void beginContact(Contact cp) {
  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  //Lava Grass COl
  if (o1.getClass() == Grass.class && o2.getClass() == Lava.class) {
    Grass g1 = (Grass) o1;
    g1.delete();
  }
  if (o1.getClass() == Lava.class && o2.getClass() == Grass.class) {
    Grass g2 = (Grass) o2;
    g2.delete();
  }

  //water Lava Col
  if (o1.getClass() == Water.class && o2.getClass() == Lava.class) {
    Lava l1 = (Lava) o2;
    l1.col();
    Water l2 = (Water) o1;
    l2.delete();
    cloudTrack = 1;
  }
  if (o1.getClass() == Lava.class && o2.getClass() == Water.class) {
    Lava l3 = (Lava) o1;
    l3.col();
    Water l4 = (Water) o2;
    l4.delete();
    cloudTrack = 1;
  }

  //Fire Grass COl
  if (o1.getClass() == Grass.class && o2.getClass() == Fire.class) {
    Grass g1 = (Grass) o1;
    g1.delete();
  }
  if (o1.getClass() == Fire.class && o2.getClass() == Grass.class) {
    Grass g2 = (Grass) o2;
    g2.delete();
  }

  //Fire Water COl
  if (o1.getClass() == Water.class && o2.getClass() == Fire.class) {
    Fire ff1 = (Fire) o2;
    ff1.delete();
  }
  if (o1.getClass() == Fire.class && o2.getClass() == Water.class) {
    Fire f3 = (Fire) o1;
    f3.delete();
  }

  //oil Lava Col
  if (o1.getClass() == Lava.class && o2.getClass() == Oil.class) {
    Oil oo1 = (Oil) o2;
    oo1.delete();
  }
  if (o1.getClass() == Oil.class && o2.getClass() == Lava.class) {
    Oil oo2 = (Oil) o1;
    oo2.delete();
  }
    //oil Fire Col
  if (o1.getClass() == Fire.class && o2.getClass() == Oil.class) {
    Oil oo1 = (Oil) o2;
    oo1.delete();
  }
  if (o1.getClass() == Oil.class && o2.getClass() == Fire.class) {
    Oil oo2 = (Oil) o1;
    oo2.delete();
  }
}

// Objects stop touching each other
void endContact(Contact cp) {
}

//restarts program
void restart()
{
  setup();
}

//switching between objects
void keyPressed() {
  if (key == 'q' || key == 'Q') {
    waterBool = false;
    rockBool = true;
    sandBool = false;
    grassBool = false;
    lavaBool = false;
    cloudBool = false;
    meteorBool = false;
    oilBool = false;
    fireBool = false;
    toolTip = "Tool: Rock";
  } else if (key == 'w' || key == 'W') {
    waterBool = true;
    rockBool = false;
    sandBool = false;
    grassBool = false;
    lavaBool = false;
    cloudBool = false;
    meteorBool = false;
    oilBool = false;
    fireBool = false;
    toolTip = "Tool: Water";
  } else if (key == 'e' || key == 'E') {
    waterBool = false;
    rockBool = false;
    sandBool = true;
    grassBool = false;
    lavaBool = false;
    cloudBool = false;
    meteorBool = false;
    oilBool = false;
    fireBool = false;
    toolTip = "Tool: Sand";
  } else if (key == 'r' || key == 'R') {
    waterBool = false;
    rockBool = false;
    sandBool = false;
    grassBool = true;
    lavaBool = false;
    cloudBool = false;
    meteorBool = false;
    oilBool = false;
    fireBool = false;
    toolTip = "Tool: Grass";
  } else if (key == 't' || key == 'T')
  {
    for (Water ww : water) {
      Vec2 wind = new Vec2(10, 0);
      ww.applyForce(wind);
    }
    toolTip = "Tool: Wave (Tap)";
  } else if (key == 'y' || key == 'Y')
  {
    waterBool = false;
    rockBool = false;
    sandBool = false;
    grassBool = false;
    lavaBool = true;
    cloudBool = false;
    meteorBool = false;
    oilBool = false;
    fireBool = false;
    toolTip = "Tool: Lava";
  } else if (key == 'u' || key == 'U')
  {
    waterBool = false;
    rockBool = false;
    sandBool = false;
    grassBool = false;
    lavaBool = false;
    cloudBool = true;
    meteorBool = false;
    oilBool = false;
    fireBool = false;
    toolTip = "Tool: Cloud";
  } else if (key == 'i' || key == 'I')
  {
    waterBool = false;
    rockBool = false;
    sandBool = false;
    grassBool = false;
    lavaBool = false;
    cloudBool = false;
    meteorBool = true;
    oilBool = false;
    fireBool = false;
    toolTip = "Tool: Meteor";
  } else if (key == 'z' || key == 'Z')
  {
    restart();
  } else if (key == 'o' || key == 'O')
  {
    waterBool = false;
    rockBool = false;
    sandBool = false;
    grassBool = false;
    lavaBool = false;
    cloudBool = false;
    meteorBool = false;
    oilBool = true;
    fireBool = false;
    toolTip = "Tool: Oil";
  } else if (key == 'p' || key == 'P')
  {
    waterBool = false;
    rockBool = false;
    sandBool = false;
    grassBool = false;
    lavaBool = false;
    cloudBool = false;
    meteorBool = false;
    oilBool = false;
    fireBool = true;
    toolTip = "Tool: Fire";
  }
}
