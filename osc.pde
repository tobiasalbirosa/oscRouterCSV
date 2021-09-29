void oscEvent(OscMessage mensaje) {
  println(mensaje);
  if (mensaje.checkAddrPattern(canalIn0) == true) {
    router.valor[0] = mensaje.get(0).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn1) == true) {
    router.valor[1] = mensaje.get(1).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn2) == true) {
    router.valor[2] = mensaje.get(2).floatValue();
  }
  if (mensaje.checkAddrPattern(canalIn3) == true) {
    router.valor[3] = mensaje.get(3).floatValue();
  }
}
