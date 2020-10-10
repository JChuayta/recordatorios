import 'package:flutter/cupertino.dart';
import 'package:recordatorio/fabrica_abstracta/producto_abstracto/Recordatorio.dart';

class IosAlert extends Recordatorio {
  IosAlert() : super('', '', '');

  @override
  Widget Alert(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Este es mi alert"),
      content: Text("contenido de mi nota"),
      actions: [
        CupertinoButton(
            child: Text("ok"), onPressed: () => Navigator.of(context).pop())
      ],
    );
  }

  @override
  Recordatorio clonar() {
    // TODO: implement clonar
    throw UnimplementedError();
  }
}
