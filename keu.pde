boolean[] keys = new boolean[256*256];
boolean[] keycodes = new boolean[256*256];

void keyPressed() {
  keys[key] = true;
  keycodes[keyCode] = true;
  if(key == ESC)exit();
  if(keyCode == ESC)exit();
}
void keyReleased() {
  keys[key] = false;
  keycodes[keyCode] = false;
}

PVector getWindowLocation(String renderer) {
  PVector l = new PVector();
  if (renderer == P2D || renderer == P3D) {
    com.jogamp.nativewindow.util.Point p = new com.jogamp.nativewindow.util.Point();
    ((com.jogamp.newt.opengl.GLWindow)surface.getNative()).getLocationOnScreen(p);
    l.x = p.getX();
    l.y = p.getY();
  } else if (renderer == JAVA2D) {
    java.awt.Frame f =  (java.awt.Frame) ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
    l.x = f.getX();
    l.y = f.getY();
  }
  return l;
}
