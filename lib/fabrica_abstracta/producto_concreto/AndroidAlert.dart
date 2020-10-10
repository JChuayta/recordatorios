import 'package:flutter/material.dart';
import '../producto_abstracto/Recordatorio.dart';

class AndroidAlert extends Recordatorio {
  AndroidAlert() : super('', '', '');
  @override
  Widget Alert(BuildContext context) {
    return AlertDialog(
      title: Text("Este es mi alert"),
      content: Text("contenido de mi nota"),
      actions: [
        RaisedButton(child: Text("ok"), onPressed: ()=>Navigator.of(context).pop())
      ],
    );
  }

  @override
  Recordatorio clonar() {
    // TODO: implement clonar
    throw UnimplementedError();
  }
}
