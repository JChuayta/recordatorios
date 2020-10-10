
import 'package:recordatorio/fabrica_abstracta/producto_abstracto/Recordatorio.dart';
import 'package:recordatorio/fabrica_abstracta/producto_concreto/IosAlert.dart';
import '../FabricaWidget.dart';

class CupertinoWidget implements FabricaWidgets{
  @override
  Recordatorio createRecordatorio() {
    // TODO: implement createRecordatorio
    return IosAlert();
  }

}