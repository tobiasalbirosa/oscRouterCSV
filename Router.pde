class Router {
  int [] graphColor;
  int [] slider;
  int cantidadDeCanales;
  float [] result;
  float[] valorViejo;
  float[] valor;
  boolean record;
  float [][] recordButton;
  Chart [] grafico;
  Chart [] graficoZoom;
  Router(int cantidadDeCanales) {
    canalIn0 = "/wimumo001/emg";
    canalIn1 = "/wimumo001/emg";
    canalIn2 = "/wimumo001/emg";
    canalIn3 = "/wimumo001/emg";
    this.cantidadDeCanales = cantidadDeCanales;
    this.slider = new int[cantidadDeCanales];
    this.grafico = new Chart[cantidadDeCanales];
    this.graficoZoom = new Chart[cantidadDeCanales];
    this.result = new float[cantidadDeCanales];
    this.valor = new float[cantidadDeCanales];
    this.grafico[0] = grafico0;
    this.grafico[1] = grafico1;
    this.grafico[2] = grafico2;
    this.grafico[3] = grafico3;
    this.graficoZoom[0] = graficoZoom0;
    this.graficoZoom[1] = graficoZoom1;
    this.graficoZoom[2] = graficoZoom2;
    this.graficoZoom[3] = graficoZoom3;
    this.iniciar();
  }  
  void iniciar() {
    for (int i = 0; i < this.cantidadDeCanales; i++) {
      this.valor[i] = 0;
      this.result[i] = 0;
      this.slider[i] = 0;
      campoDeTexto(i);
      sliderDeZoom(i);
      graficos(i);
      graficosZoom(i);
      modulosOSC(i);
    }
  }
  void actualizar() {
    y = year();
    mo = month();
    d = day();
    s = second();
    min = minute();
    h = hour();
    ms = millis()%1000;
    ds = ms/100;
    cs = ms/10;
    background(0);
    pushStyle();
    fill(80);
    noStroke();
    rect(width/2, 0, width/6, height);
    fill(255);
    rect(width/2+width/8, 0, width/2, height);
    this.grabar(width/2+width/6, height/3, width/50);
    popStyle();
    this.consola();
    this.slider[0] = zoom0;
    this.slider[1] = zoom1;
    this.slider[2] = zoom2;
    this.slider[3] = zoom3;
    for (int i = 0; i < cantidadDeCanales; i++) {
      modulosOSC(i);
      this.result[i] = (this.valor[i] * this.slider[i]);
      this.grafico[i].push(this.valor[i]);
      this.graficoZoom[i].push(this.result[i]);
    }
    if (mousePressed) {
      fill(0, 255, 0);
    } else {
      fill(255);
    }
  }
  void consola() {
    pushStyle();
    fill(0);
    text("HOST: "+currentHost+":12000", width/2+width/8, 20);
    text("FPS: "+frameRate, width/2+width/8, 44);
    text("Fecha y hora: "+d+":"+mo+":"+y+"/"+h+":"+min+":"+s+":"+ds+":"+cs+":"+ms, width/2+width/8, 68);
    text("INVESTIGACION FASCIA", width/2+width/8, 92);
    popStyle();
  }
  void graficos(int canal) {
    this.grafico[canal] = cp5.addChart("grafico"+canal)
      .setPosition(cantidadDeCanales, height/cantidadDeCanales*canal+cantidadDeCanales)
      .setSize(width/12, width/12)
      .setRange(0, 1000000)
      .setView(Chart.LINE)
      .setStrokeWeight(1.5)
      .setColorCaptionLabel(color(255))
      ;
    this.grafico[canal].addDataSet("grafico"+canal);
    this.grafico[canal].setData("grafico"+canal, new float[360]);
  }
  void graficosZoom(int canal) {
    this.graficoZoom[canal] = cp5.addChart("graficoZoom"+canal)
      .setPosition(width/2+cantidadDeCanales, height/cantidadDeCanales*canal+cantidadDeCanales)
      .setSize(width/12, width/12)
      .setRange(0, 1000000)
      .setView(Chart.LINE)
      .setStrokeWeight(1.5)
      .setColorCaptionLabel(color(255))
      ;
    this.graficoZoom[canal].addDataSet("graficoZoom"+canal);
    this.graficoZoom[canal].setData("graficoZoom"+canal, new float[360]);
  }
  void modulosOSC(int canal) {
    pushMatrix();
    stroke(255);
    text("Recibido: ", width/10, height/cantidadDeCanales*canal+height/7);
    text(valor[canal], cantidadDeCanales, height/cantidadDeCanales*canal+height/6);
    text("Zoom: ", width/3+cantidadDeCanales, height/cantidadDeCanales*canal+height/7);
    text(result[canal], width/2+cantidadDeCanales, height/cantidadDeCanales*canal+height/6);
    if (valor[canal] >= 0.1) {
      fill(0, 255, 0, 255);
      square(width/12, height/cantidadDeCanales*canal+height/7, width/48);
    }
    popMatrix();
  }
  void sliderDeZoom(int canal) {
    cp5.addSlider("zoom"+canal)
      .setPosition(width/12+(cantidadDeCanales*2), height/cantidadDeCanales*canal+height/48)
      .setSize(width/3, 10)
      .setRange(1, 1000000)
      ;
  }
  void campoDeTexto(int canal) {
    cp5.addTextfield("canalIn"+canal)
      .setPosition(width/6, height/cantidadDeCanales*canal+height/6)
      .setSize(width/6, height/cantidadDeCanales/5)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      ;
    cp5.addTextfield("titulo"+canal)
      .setPosition(width/6, height/cantidadDeCanales*canal+height/12)
      .setSize(width/6, height/cantidadDeCanales/5)
      .setFont(createFont("arial", 14))
      .setAutoClear(false)
      ;
  }
  void botonGrabar(float posX, float posY, float tam) {
    rect(posX-tam, posY-tam, width/3-tam, tam*2);
  }
  void grabando() {
    if (dist(width/2+width/6, height/3, mouseX, mouseY) < width/50) {
      record = !record;
      if (record) {
        sessionName = d+"_"+mo+"_"+y+"-"+h+"_"+m+"_"+s+"_"+ds+"_"+cs+"_"+ms;
      }
    }
  }
  void grabar(float posX, float posY, float tam) {
    pushStyle();
    fill(255);
    stroke(120);
    this.botonGrabar(posX, posY, tam);
    if (record) {
      fill(220, 0, 0);
      square(posX-tam/2, posY-tam/2, tam);
      text("Grabando: /sessions/"+ sessionName, posX + tam, posY);
    } else {   
      fill(60, 0, 0);
      circle(posX, posY, tam);
      text("Grabar", posX + tam, posY);
    }
    popStyle();
  }
  void guardarTabla() {
    if (this.record) {
      TableRow newRow = table.addRow();
      messageTime = d+"/"+mo+"/"+y+"-"+h+":"+min+":"+s+"::"+ds+"::"+cs+"::"+ms;
      newRow.setString("hora", messageTime);
      newRow.setFloat("v1 crudo", this.valor[0]);
      newRow.setFloat("v2 crudo", this.valor[1]);
      newRow.setFloat("v3 crudo", this.valor[2]);
      newRow.setFloat("v4 crudo", this.valor[3]);
      newRow.setFloat("v1", this.result[0]);
      newRow.setFloat("v2", this.result[1]);
      newRow.setFloat("v3", this.result[2]);
      newRow.setFloat("v4", this.result[3]);
      saveTable(table, "data/sesions/"+sessionName+".csv");
    }
  }
}
