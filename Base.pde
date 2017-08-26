/* ------------------------------------------------------------------------------------------
 Base Class
 ------------------------------------------------------------------------------------------*/

int TDRINK = 0;
int TCUP = 1;
int TGUEST = 2;
int TEMPTYCUP = 3;
int TBUTTON = 4;

class Node
{
  PImage img;
  int type;
  public int posx, posy;
  public int x1, y1, x2, y2;

  Node () 
  {
  }

  int getType()
  {
    return type;
  }

  boolean hover()
  {
    if (pointRect(mouseX, mouseY, x1, y1, x2, y2)) 
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  boolean clickTest(int _x, int _y)
  {
    if (pointRect(_x, _y, x1, y1, x2, y2)) 
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  void aabb()
  {
    // calc AABB
    x1 = posx - img.width / 2;
    x2 = posx + img.width / 2;

    y1 = posy - img.height / 2;
    y2 = posy + img.height / 2;
  }

  void render()
  {
  }

  void callback()
  {
  }
}

class Timer {

  int savedTime;
  int totalTime;
  int passedTime;
  boolean isFire;

  int time;
  int lasttime;

  Timer(int tempTotalTime)
  {
    totalTime = tempTotalTime;
    isFire = false;
    time = 0;
  }

  void start() 
  {
    time = 0;
    lasttime = millis();
    isFire = true;
  }

  boolean isFinished()
  { 

    if (isFire == false) 
    {
      return false;
    }

    int deltatime = millis() - lasttime;

    if (GAMEPAUSE != true)
    {
      time = time + deltatime;
    }

    lasttime = millis();

    if (time > totalTime) 
    {
      isFire = false;
      return true;
    }
    else
    {
      return false;
    }
  }

  int getRestTime()
  {
    return totalTime - time;
  }
}

