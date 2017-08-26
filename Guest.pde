/**
 *  Guest class
 */

String[] wines = {
  "beer", 
  "whiskey", 
  "vodka", 
  "rum", 
  "jagermeister",
  "mystery", 
  "abs", 
  "tequilla"
};

int[] cupidx = {1, 2, 2, 2, 3, 3, 3, 3};

class Guest extends Node
{
  Timer timer;
  Timer ordertimer;
  Timer drinktimer;

  int maxAlcohol;
  int drunkMeter;

  int id;

  int hidden;
  boolean dead;


  int order;

  PImage body;
  PImage drinkImge;

  Guest(int c, int _id) 
  {
    id = _id;
    type = TGUEST;

    String fname;
    fname = id + "1.png";
    img = loadImage(fname);

    timer = new Timer(1000);

    ordertimer = new Timer(1500);
    ordertimer.start();

    drinktimer = new Timer(4000);

    drunkMeter = 1;
    maxAlcohol = 8;

    int bid = int(random(255)) % 6;

    fname = "b" + bid + ".png";
    body = loadImage(fname);

    posx = 250 + 280 * c;
    posy = 290;

    aabb();

    //init sound
    fname = "snd1.mp3";
    AudioSnippet snd = minim.loadSnippet(fname);
    snd.play(0);

    hidden = 0;
    dead = false;

    order = -1;
  }

  boolean isDead()
  {
    return dead;
  }

  void render() 
  {
    if (ordertimer.isFinished()) 
    {
      order = int(random(255)) % 8;
      String fname = "snd0" + order + ".mp3";
      AudioSnippet snd = minim.loadSnippet(fname);
      snd.play(0);

      fname = "h" + order + ".png";
      drinkImge = loadImage(fname);
    }

    if (drinktimer.isFinished()) 
    {
      String fname;
      fname = id + "1.png";
      img = loadImage(fname);
      ordertimer.start();
    }


    noTint();

    pushMatrix();
    translate(posx, posy);
    image(body, 0, img.height/2);
    if (order != -1)
    {
      image(drinkImge, 0, -130);
    }
    popMatrix();

    pushMatrix();
    translate(posx, posy);
    if (hover()) 
    {
      scale(1.1);
    }
    if (hidden >= 1 && hidden <= 255)
    {
      tint(255, 255 - hidden);
      hidden++;

      if (hidden == 255)
      {
        dead = true;
      }
    }
    image(img, 0, 0);
    popMatrix();

    pushMatrix();
    translate(posx - img.width/2, posy - 80);
    float r = map (drunkMeter, 0, maxAlcohol, 0, 255);
    float g = map (drunkMeter, 0, maxAlcohol, 255, 0);
    fill (r, g, 0);
    float p = (float)drunkMeter / (float)maxAlcohol * 100.0;
    rect(0, 0, p, 10);

    popMatrix();

    if (timer.isFinished()) 
    {
      String fname = "snd4.mp3";
      AudioSnippet snd = minim.loadSnippet(fname);
      snd.play(0);
      hidden = 1;
    }

    noTint();
  }

  void callback()
  {
  }

  boolean drink(Cup c)
  {
    if (c.drink.wineType == order) 
    {
      if (drunkMeter < maxAlcohol)
      {
        drunkMeter += c.drink.alcovolume;
        String fname = "snd2.mp3";
        AudioSnippet snd = minim.loadSnippet(fname);
        snd.play(0);

        fname = id + "2" + cupidx[order] + ".png";
        img = loadImage(fname);
        drinktimer.start();
        order = -1;
      }

      if (drunkMeter >= maxAlcohol)
      {
        String fname = id + "4.png";
        img = loadImage(fname);

        timer.start();
      }
      else
      {
        order = -1;
      }

      return true;
    } 
    else
    {
      String fname = "snd3.mp3";
      AudioSnippet snd = minim.loadSnippet(fname);
      snd.play(0);

      fname = id + "3.png";
      img = loadImage(fname);
      drinktimer.start();
      order = -1;

      return false;
    }
  }
}

