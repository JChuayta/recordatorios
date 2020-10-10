import 'package:flutter/src/widgets/framework.dart';
import 'package:recordatorio/fabrica_abstracta/producto_abstracto/Recordatorio.dart';
import 'package:flutter/material.dart';
class Nota extends Recordatorio{

  Nota(String contenido, String titulo, String fechahora) : super(contenido, titulo, fechahora);

 

  @override
  Recordatorio clonar() {
    return new Nota(this.getContenido, this.getTitulo,this.getFechaHora);
  }

  @override
  Widget Alert(BuildContext context) {
    // TODO: implement Alert
    throw UnimplementedError();
  }

}