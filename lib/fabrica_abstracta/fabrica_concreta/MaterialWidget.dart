
import 'package:recordatorio/fabrica_abstracta/producto_abstracto/Recordatorio.dart';
import 'package:recordatorio/fabrica_abstracta/producto_concreto/AndroidAlert.dart';
import '../FabricaWidget.dart';

class MaterialWidget implements FabricaWidgets{
  @override
  Recordatorio createRecordatorio() {
    // TODO: implement createRecordatorio
    return AndroidAlert();
  }

}