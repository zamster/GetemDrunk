/**
 *  UIMenu class
 */

class UIButton extends Node
{
  UIButton ()
  {
    type = TBUTTON;
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

class UIStartButton extends UIButton
{
  UIStartButton ()
  {
    posx = width/2;
    posy = height/2;
    img = loadImage("menu_s.png");

    aabb();
  }

  void callback()
  {
    MAIN = new GameScene("bar.png");

    MAIN.addObj(new Guest(0, int(random(255)) % 5 + 1));
    MAIN.addObj(new Guest(1, int(random(255)) % 5 + 1));
    MAIN.addObj(new Guest(2, int(random(255)) % 5 + 1));

    MAIN.addObj(new EmptyCup(1, width/2, 32));
    MAIN.addObj(new EmptyCup(2, 280, 550));
    MAIN.addObj(new EmptyCup(3, 750, 550));

    MAIN.addObj(new Drink("beer.png", 0, 1, 1, 144, 392));

    MAIN.addObj(new Drink("whiskey.png", 1, 3, 2, 237, 432));
    MAIN.addObj(new Drink("vodka.png", 2, 3, 2, 293, 433));
    MAIN.addObj(new Drink("rum.png", 3, 2, 2, 354, 433));

    MAIN.addObj(new Drink("jager.png", 4, 3, 3, 657, 452));
    MAIN.addObj(new Drink("mystery.png", 5, 2, 3, 727, 452));
    MAIN.addObj(new Drink("abs.png", 6, 3, 3, 797, 452));
    MAIN.addObj(new Drink("tequila.png", 7, 2, 3, 867, 452));

    MAIN.addObj(new UIPauseButton());

    CURSCENE = MAIN;
  }

}

class UIPauseButton extends UIButton
{
  UIPauseButton ()
  {
    posx = width - 44;
    posy = height - 44;
    img = loadImage("pausebtn.png");
    aabb();
  }

  void callback()
  {
    GAMEPAUSE = true;

    PAUSE = new PauseScene("pausescrn.png");

    PAUSE.addObj(new UIResumeButton());
    PAUSE.addObj(new UIRestartButton());
    PAUSE.addObj(new UIExitButton());

    CURSCENE = PAUSE;
  }
}

class UIResumeButton extends UIButton
{
  UIResumeButton ()
  {
    posx = width/2 ;
    posy = height/2;
    img = loadImage("resumebtn.png");
    aabb();
  }

  void callback()
  {
    CURSCENE = MAIN;
    GAMEPAUSE = false;
  }
}

class UIRestartButton extends UIButton
{
  UIRestartButton ()
  {
    posx = width/2 -200;
    posy = height/2;
    img = loadImage("restartbtn.png");
    aabb();
  }

  void callback()
  {
    MAIN = new GameScene("bar.png");

    MAIN.addObj(new Guest(0, int(random(255)) % 5 + 1));
    MAIN.addObj(new Guest(1, int(random(255)) % 5 + 1));
    MAIN.addObj(new Guest(2, int(random(255)) % 5 + 1));

    MAIN.addObj(new EmptyCup(1, width/2, 32));
    MAIN.addObj(new EmptyCup(2, 280, 550));
    MAIN.addObj(new EmptyCup(3, 750, 550));

    MAIN.addObj(new Drink("beer.png", 0, 1, 1, 174, 392));

    MAIN.addObj(new Drink("whiskey.png", 1, 3, 2, 287, 432));
    MAIN.addObj(new Drink("vodka.png", 2, 3, 2, 353, 433));
    MAIN.addObj(new Drink("rum.png", 3, 2, 2, 419, 433));

    MAIN.addObj(new Drink("jager.png", 4, 3, 3, 637, 452));
    MAIN.addObj(new Drink("mystery.png", 5, 2, 3, 707, 452));
    MAIN.addObj(new Drink("abs.png", 6, 3, 3, 777, 452));
    MAIN.addObj(new Drink("tequila.png", 7, 2, 3, 847, 452));
    MAIN.addObj(new UIPauseButton());

    CURSCENE = MAIN;

    GAMEPAUSE = false;
  }
}

class UIExitButton extends UIButton
{
  UIExitButton ()
  {
    posx = width/2 + 200;
    posy = height/2;
    img = loadImage("quitbtn.png");
    aabb();
  }

  void callback()
  {
    CURSCENE = MENU;
    GAMEPAUSE = false;
  }
}


