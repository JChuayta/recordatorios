import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

abstract class Recordatorio {
  String _contenido;
  String _titulo;
  String _fechahora;

  Recordatorio(String contenido,String titulo,String fechahora){
    this._contenido=contenido;
    this._titulo=titulo;
    this._fechahora=fechahora;
  }

  set setContenido(String contenido) {
    this._contenido = contenido;
  }

  set setTitulo(String titulo) {
    this._titulo = titulo;
  }

  set setFechaHora(String fechahora) {
    this._fechahora = fechahora;
  }

  String get getContenido => this._contenido;
  String get getTitulo => this._titulo;
  String get getFechaHora => this._fechahora;

  Widget Alert(BuildContext context);

  Recordatorio clonar();

}
