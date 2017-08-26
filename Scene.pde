/**
 *  Scene class
 */

class Scene
{
  ArrayList<Node> renderObjs;
  PImage bg;

  Scene(String filename)
  {
    renderObjs = new ArrayList<Node>();
    bg = loadImage(filename);
  }

  void addObj(Node n)
  {
    renderObjs.add(n);
  }

  void render() 
  {
  }

  void clickTest(int _x, int _y)
  {
  }
}

class GameScene extends Scene
{
  Drink curSelDrink;
  Cup curSelCup;
  Guest curSelGuest;
  EmptyCup curSelEmptyCup;

  int money;

  Timer gameTime;

  PImage bar_img;

  GameScene (String filename)
  {
    super(filename);
    money = 0;
    gameTime = new Timer(120000);
    gameTime.start();
    bar_img = loadImage("bar_bg.png");
  }

  void render() 
  {
    image(bg, width/2, height/2);
    for ( int i = 0; i < 3; i++)
    {
      renderObjs.get(i).render();
    }

    image(bar_img, width / 2, 510);

    for ( int i = 3; i < renderObjs.size(); i++)
    {
      renderObjs.get(i).render();
    }

    for ( int i = 0; i < 3; i++)
    {
      Guest n = (Guest) renderObjs.get(i);

      if (n.isDead())
      {
        renderObjs.remove(i);
        int g = int(random(255)) % 5 + 1;
        renderObjs.add(i, new Guest(i, g));
      }
    }

    fill(255);
    textSize(32);
    text("$:" + money, 880, 70);

    if (!gameTime.isFinished())
    {
      int minute = gameTime.getRestTime() / 1000 / 60;
      int second = gameTime.getRestTime() / 1000 % 60;
      String time = minute + ":" + second;
      text(time, 30, 70);
    } 
    else
    {
      MENU.setHishScore(money);
      CURSCENE = MENU;
    }
  }

  void clickTest(int _x, int _y)
  {
    for ( int i = 0; i < renderObjs.size(); i++) 
    {
      Node n = renderObjs.get(i);
      if (n.clickTest(_x, _y) == true)
      {
        n.callback();
        int t = n.getType();

        if (t == TDRINK)
        {
          curSelDrink = (Drink) n;
          checkDrink();
        }

        if (t == TCUP)
        {
          curSelCup = (Cup) n;
        }

        if (t == TGUEST)
        {
          curSelGuest = (Guest) n;
          checkGuest();
        }

        if (t == TEMPTYCUP)
        {
          if (curSelEmptyCup == null)
          {
            curSelEmptyCup = (EmptyCup) n;
            curSelCup = new Cup(curSelEmptyCup.cupType);
            renderObjs.add(curSelCup);
          }
          else
          {
            renderObjs.remove(renderObjs.size()-1);
            curSelEmptyCup = (EmptyCup) n;
            curSelCup = new Cup(curSelEmptyCup.cupType);
            renderObjs.add(curSelCup);
          }
        }

        break;
      }
    }
  }

  void checkDrink()
  {
    if (curSelDrink != null && curSelEmptyCup != null) 
    {
      if (curSelDrink.cupType == curSelEmptyCup.cupType) 
      {
        curSelCup.fullfill(curSelDrink);
        curSelDrink = null;
      }
    }
  }

  void checkGuest()
  {
    if (curSelCup != null && curSelCup.isFill() ) 
    {
      if (curSelGuest.drink(curSelCup) == true)
      {
        money += 100;
      }
      renderObjs.remove(renderObjs.size()-1);
      curSelEmptyCup = null;
      curSelCup = null;
    }
  }

  int getTime()
  {
    return gameTime.getRestTime();
  }
  
  int getScore()
  {
    return money;
  }
}

class MenuScene extends Scene
{
  int[] highscores = new int[5];

  MenuScene(String filename)
  {
    super(filename);
  }

  void setHishScore(int h)
  {
    for (int i = 0; i < 5; i++)
    {
      if (highscores[i] == 0)
      {
        highscores[i] = h;
        highscores = sort(highscores);
        highscores = reverse(highscores);
        return;
      }
    }

    for (int i = 0; i < 5; i++)
    {
      if (h > highscores[i]) 
      {
        highscores[i] = h;
        highscores = sort(highscores);
        highscores = reverse(highscores);
        break;
      }  
    };
  }

  void render() 
  {
    image(bg, width/2, height/2);
    for ( int i = 0; i < renderObjs.size(); i++)
    {
      renderObjs.get(i).render();
    }

    textSize(32);
    text(highscores[0], width/2, 500);
  }

  void clickTest(int _x, int _y)
  {
    for ( int i = 0; i < renderObjs.size(); i++) 
    {
      Node n = renderObjs.get(i);
      if (n.clickTest(_x, _y) == true)
      {
        n.callback();
        break;
      }
    }
  }
}

class PauseScene extends Scene
{
  int score;
  int timeLeft;
  PFont mono;
  
  PauseScene(String filename)
  {
    super(filename);
    score = MAIN.getScore();
    timeLeft = MAIN.getTime();
    //mono = loadFont("Kosmik-BoldTwo.otf");
  }

  void render() 
  {
    image(bg, width/2, height/2);
    for ( int i = 0; i < renderObjs.size(); i++)
    {
      renderObjs.get(i).render();
    }
    int minute = timeLeft / 1000 / 60;
    int second = timeLeft / 1000 % 60;
    String time = minute + ":" + second;
    
    textSize(28);
    //textFont(mono);
    text(time, 880, 70);

    textSize(28);
    //textFont(mono);
    text(score, 30, 70);
    }

  void clickTest(int _x, int _y)
  {
    for ( int i = 0; i < renderObjs.size(); i++) 
    {
      Node n = renderObjs.get(i);
      if (n.clickTest(_x, _y) == true)
      {
        n.callback();
        break;
      }
    }
  }
}

