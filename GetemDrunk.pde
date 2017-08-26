/* ------------------------------------------------------------------------------------------
 G 
 ------------------------------------------------------------------------------------------*/

import ddf.minim.*;

AudioPlayer player;
Minim minim;

MenuScene MENU;
GameScene MAIN;
PauseScene PAUSE;
Scene CURSCENE;

boolean GAMEPAUSE;

void setup() 
{
  size(1024, 623, P3D);
  smooth();
  imageMode(CENTER);
  textFont(loadFont("Kosmik-BoldOne-48.vlw"), 64);

  minim = new Minim(this);
  player = minim.loadFile("bgm.mp3");
  player.setVolume(0.5);
//  player.loop();

  GAMEPAUSE = false;

  MENU = new MenuScene("menu.png");
  MENU.addObj(new UIStartButton());

  CURSCENE = MENU;
}

/* ------------------------------------------------------------------------------------------
 User Control
 ------------------------------------------------------------------------------------------*/
void mouseClicked()
{
  CURSCENE.clickTest(mouseX, mouseY);
}

/* ------------------------------------------------------------------------------------------
 Render Function
 ------------------------------------------------------------------------------------------*/
void draw()
{
  background(0);
  CURSCENE.render();
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
