import oscP5.*;
import netP5.*;
import controlP5.*;
OscP5 oscP5;
ControlP5 cp5;
float m1, m2, m3, m4;
String currentHost;
int cantidadDeCanales = 4;
String canalIn0, canalIn1, canalIn2, canalIn3;
int zoom0, zoom1, zoom2, zoom3;
Chart grafico0, grafico1, grafico2, grafico3;
Chart graficoZoom0, graficoZoom1, graficoZoom2, graficoZoom3;
Router router;
Table table;
String sessionName;
String messageTime;
int d;
int mo;
int y; 
int s; 
int min;
int h;
int ms;
int ds;
int cs;
int millis;
public void settings() {
  size(displayWidth/2, displayHeight-100);
}
public void setup() {
  background(0);
  cp5 = new ControlP5(this);
  frameRate(60);
  table = new Table();
  table.addColumn("hora");
  table.addColumn("v1 crudo");
  table.addColumn("v2 crudo");
  table.addColumn("v3 crudo");
  table.addColumn("v4 crudo");
  table.addColumn("v1");
  table.addColumn("v2");
  table.addColumn("v3");
  table.addColumn("v4");
  try {
    currentHost = java.net.InetAddress.getLocalHost().getHostAddress();
  }
  catch(Exception e) {
    currentHost = "0.0.0.0";
  }
  oscP5 = new OscP5(this, 12000);
  router = new Router(cantidadDeCanales);
  textSize(12);
}
void draw () {
  router.actualizar();
  router.guardarTabla();
  /* 
     FINALIZE RUTINES WAITING FOR ENDING ? ...
     https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/lang/System.html#gc()
     ----->
  */
  Runtime.getRuntime().runFinalization();
}
void mouseClicked() {
  router.grabando();
}
