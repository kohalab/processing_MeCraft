import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.Component;

Robot robot;

void setup() {
  try {
    robot = new Robot();
  }
  catch(AWTException e) {
  };
  size(640, 480, P3D);
  noSmooth();
}

color sora = color(200, 230, 255);

//camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)

void drawbox(int x, int y, int z, int xs, int ys, int zs) {
  pushMatrix();
  translate(x, y, z);
  box(xs, ys, zs);
  popMatrix();
}

float px, py, pz, pxs, pys, pzs;
float rx, ry;

void draw() {
  int screenX = (int)getWindowLocation(P3D).x;
  int screenY = (int)getWindowLocation(P3D).y;
  int screenCenterX = (int)getWindowLocation(P3D).x+(width/2);
  int screenCenterY = (int)getWindowLocation(P3D).y+(height/2);
  int mvx = mouseX-(width/2);
  int mvy = mouseY-(height/2);
  if(frameCount == 1){
    mvx = 0;
    mvy = 0;
  }
  if(true)robot.mouseMove(screenCenterX,screenCenterY);
  //println(getWindowLocation(P3D).x,getWindowLocation(P3D).y);
  float ex = 0, ey = 0, ez = 8*16, cx = 0, cy = 0, cz = 0;

  float rox = (1*cos(rx))*(1*cos(ry));
  float roy = (1*sin(ry));
  float roz = (1*sin(rx))*(1*cos(ry));

  cx = px;
  cy = py;
  cz = pz;

  ex = px+rox*0.1;
  ey = py+roy*0.1;
  ez = pz+roz*0.1;

  camera(ex, ey, ez, cx, cy, cz, 0, 1, 0);

  background(sora);

  ambientLight(128, 128, 128);
  directionalLight(128, 128, 128, px, py, pz);


  fill(255);
  //stroke(0);
  noStroke();

  boolean asi = false;

  for (int z = int(pz/16)-12; z < int(pz/16)+12; z++) {
    for (int i = int(px/16)-16; i < int(px/16)+16; i++) {
      for (int f = int(py/16)-12; f < int(py/16)+12; f++) {
        int b = get_map(i, f, z);
        int c = 0;
        if (b == 1) {
          //
          if (((i*16)-8) < px && ((i*16)+8) >= px) {
            if (((f*16)-8) < py+64 && ((f*16)+8) >= py+64) {
              if (((z*16)-8) < pz && ((z*16)+8) >= pz) {
                c = 1;
                pys = -0.01;
                py = (f*16)-64;
                println("!!!! "+i+" "+f+" "+z);
                asi = true;
              }
            }
          }
          //
        }

        if (b == 1) {
          //float a = k(int(px/16),i)+k(int(py/16),f)+k(int(pz/16),z);
          //float t = (a/30.0);
          //t -= 0.4;
          float R = noise((i/16.0)+014, (f/16.0)+137, z/8.0)*256;
          float G = noise((i/16.0)+500, (f/16.0)+127, z/8.0)*256;
          float B = noise((i/16.0)+401, (f/16.0)+100, z/8.0)*256;
          //if(t < 0)t = 0;
          //if(t > 1)t = 1;
          //fill( aida(R,red(sora),t),aida(G,green(sora),t),aida(B,blue(sora),t) );
          fill(R, G, B);
          if (c == 1)fill(255, 0, 255);
          drawbox(int((i)*16), int((f)*16), int((z)*16), 16, 16, 16);
        }
        //
      }
    }
  }
  //

  px += pxs;
  py += pys;
  pz += pzs;

  //if (keys['w'])ry += 0.04;
  //if (keys['s'])ry -= 0.04;
  //if (keys['a'])rx -= 0.04;
  //if (keys['d'])rx += 0.04;
  rx += mvx/100.0;
  ry -= mvy/100.0;
  
  if(ry > HALF_PI-0.01)ry = HALF_PI-0.01;
  if(ry < -(HALF_PI-0.01))ry = -(HALF_PI-0.01);

  if (keys['w']) {
    pxs -= rox;
    //pys -= roy;
    pzs -= roz;
  }
  if (keys['s']) {
    pxs -= -rox;
    //pys -= -roy;
    pzs -= -roz;
  }
  if (keys[' '] && asi) {
    py -= 16;
    pys = -6;
  }

  pys += 0.3;

  pxs /= 1.5;
  //pys /= 1.5;
  pzs /= 1.5;

  println((int)px/16, (int)py/16, (int)pz/16);
  //
}

float k(float a, float b) {
  return (a-b) >= 0?(a-b):-(a-b);
}

float aida(float a, float b, float x) {
  return a + ((b - a) * x);
}
