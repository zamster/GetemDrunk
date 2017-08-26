/**
 *  Cup class
 */

class Cup extends Node
{
  boolean isSelect;
  public Drink drink;
  public int cupType;
  PImage area;

  boolean showHint;

  Cup (int t)
  {
    type = TCUP;
    cupType = t;
    posx = width/2;
    posy = height/2 + 150;

    String fname;
    fname = "cup" + cupType + ".png";
    img = loadImage(fname);

    area = loadImage("ga.png");
    isSelect = false;
    showHint = false;
    aabb();
  }

  void reset()
  {
    isSelect = false;
    showHint = false;
    posx = width/2;
    posy = height/2 + 150;
    aabb();
  }

  boolean isFill()
  {
    if (drink != null)
    {
      return true;
    }
    return false;
  }

  void fullfill(Drink _d)
  {
    drink = _d;
    String fname;
    int dt = drink.wineType;
    fname = "fcup" + dt + ".png";
    img = loadImage(fname);
    showHint = true;
  }

  void render()
  {
    pushMatrix();

    if (isSelect)
    {
      posx = mouseX;
      posy = mouseY;
      aabb();
    }

    translate(posx, posy);

    if (!isSelect) 
    {
      image(area, 0, 0);
      if (showHint == true) 
      {
        image(loadImage("pick_customer.png"), 0, -60);
      }
      else
      {
        image(loadImage("pick_drink.png"), 0, -60);
      }
    }

    if (hover()) 
    {
      scale(1.1);
    }
    else
    {
      scale(1.0);
    }
    image(img, 0, 0);
    popMatrix();
  }


  void callback()
  {
    isSelect = !isSelect;

    if (isSelect == false) 
    {
      reset();
    }
  }
}

class EmptyCup extends Node
{
  public int cupType;

  EmptyCup ( int t, int x, int y )
  {
    type = TEMPTYCUP;
    posx = x;
    posy = y;

    cupType = t;

    String fname;
    fname = "ec" + cupType + ".png";

    img = loadImage(fname);

    aabb();
  }

  void render()
  {
    pushMatrix();
    translate(posx, posy);

    if (hover()) 
    {
      scale(1.1);
    }
    else
    {
      scale(1.0);
    }
    image(img, 0, 0);
    popMatrix();
  }


  void callback()
  {
  }
}

