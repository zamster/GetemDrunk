/**
 *  Drink class
 */

class Drink extends Node
{
  public int wineType;
  boolean isSelect;
  public int alcovolume;

  int oposx, oposy;
  PImage himg;

  public int cupType;

  Drink (String filename, int _p, int _av, int _ct, int ox, int oy)
  {
    wineType = _p;
    type = TDRINK;

    oposx = ox;
    oposy = oy;

    posx = oposx;
    posy = oposy;
    img = loadImage(filename);

    String fname;
    fname = "h" + wineType + ".png";
    himg = loadImage(fname);

    isSelect = false;

    aabb();

    alcovolume = _av;
    cupType = _ct;
  }

  void render()
  {
    pushMatrix();

    translate(posx, posy);

    if (hover()) 
    {
      scale(1.1);
      image(img, 0, 0);
      image(himg, 0, -150);
    }
    else
    {
      scale(1.0);
      image(img, 0, 0);
    }

    popMatrix();
  }

  void callback()
  {
  }
}

