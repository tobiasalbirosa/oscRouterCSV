import oscP5.*;
import netP5.*;
import controlP5.*;
OscP5 oscP5;
NetAddress ipRemoto;
ControlP5 cp5;
float m1, m2, m3, m4;
String m, canalOut, currentHost;
int cantidadDeCanales = 4;
String canalIn0, canalIn1, canalIn2, canalIn3;
int zoom0, zoom1, zoom2, zoom3;
boolean RECEIVE0, RECEIVE1, RECEIVE2, RECEIVE3;
boolean SEND0, SEND1, SEND2, SEND3;
Chart grafico0, grafico1, grafico2, grafico3;
Chart graficoZoom0, graficoZoom1, graficoZoom2, graficoZoom3;
Router router;
Table table;
String sessionName;
String messageTime;
int d = day();
int mo = month();
int y = year(); 
int s = second(); 
int min = minute();
int h = hour();
int ms = millis()%1000;
int ds = round(ms/100);
int cs =  round(ms/10);
int millis = millis()/10;
public void settings() {
  size(displayWidth, displayHeight);
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
  surface.setResizable(true);
  try {
    println(java.net.InetAddress.getLocalHost().getHostAddress());
    currentHost = java.net.InetAddress.getLocalHost().getHostAddress();
  }
  catch(Exception e) {
    currentHost = "0.0.0.0";
  }
  oscP5 = new OscP5(this, 12000);
  canalOut = "/message";
  router = new Router(cantidadDeCanales);
  textSize(24);
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
