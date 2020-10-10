import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:recordatorio/fabrica_abstracta/producto_abstracto/Recordatorio.dart';
import 'package:recordatorio/prototipo/Nota.dart';
import 'fabrica_abstracta/FabricaWidget.dart';
import 'fabrica_abstracta/fabrica_concreta/CupertinoWidget.dart';
import 'fabrica_abstracta/fabrica_concreta/MaterialWidget.dart';
import 'fabrica_abstracta/producto_abstracto/Recordatorio.dart';
import 'estrategia/ColorEstrategy.dart';
import 'package:recordatorio/estrategia/ColorAmarillo.dart';
import 'package:recordatorio/estrategia/ColorAzul.dart';
import 'package:recordatorio/estrategia/ColorRosa.dart';
import 'package:recordatorio/estrategia/ColorVerde.dart';
import 'package:recordatorio/estrategia/ColorRojo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MiHome(),
      ),
    );
  }
}

class MiHome extends StatefulWidget {
  @override
  _MiHomeState createState() => _MiHomeState();
}

class _MiHomeState extends State<MiHome> {
  String fecha;
  DateTime _dateSelected = DateTime.now();
  TextEditingController tituloController = new TextEditingController();
  TextEditingController contenidoController = new TextEditingController();

  //instancias de los patrones de dise;o
  List<Recordatorio> misNotas = [];
  FabricaWidgets fabrica =
      new MaterialWidget(); //INSTANCIA DEL PATRON FABRICA ABSTRACTA
  Recordatorio
      _recordatorio; // INSANCIA DEL PATRON FABRICA ABSTRACTA Y PROTOTIPE
  Color colr;
  void _showAlertDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext _) {
        return _recordatorio.Alert(context);
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateSelected,
        firstDate: new DateTime(2000),
        lastDate: new DateTime(2025));
    if (picked != null && _dateSelected != null) {
      setState(() {
        _dateSelected = picked;
        fecha = _dateSelected.day.toString() +
            '-' +
            _dateSelected.month.toString() +
            '-' +
            _dateSelected.year.toString();
      });
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _recordatorio = fabrica.createRecordatorio();
    /*Timer.periodic(Duration(seconds: 5), (nada) {
      if(fecha == _dateSelected.day.toString() + '-' + _dateSelected.month.toString() + '-' +   _dateSelected.year.toString()){
        _showAlertDialog();
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.pink,
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "Todas mis Notas",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: misNotas.length,
            itemBuilder: (context, index) {
              final item = misNotas[index];
              return Container(
                height: MediaQuery.of(context).size.height / 7,
                child: CardLista(colr, index, this._recordatorio),
              );
            },
          ),
        ),
        _crearBoton(),
      ],
    );
  }

  Widget CardLista(Color color, int index, Recordatorio record) {
    return Card(
        color: color,
        elevation: 3.0,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Clonar Nota"),
                  content:
                      const Text("Desea Clonar la nota con los mismos datos?"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            record = misNotas[index];
                            Recordatorio rec = record.clonar();
                            misNotas.add(rec);
                          });
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Si Obvio")),
                    FlatButton(
                      onPressed: () {
                        modal();
                      },
                      child: const Text("Nell"),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15.0, left: 15.0),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    misNotas[index].getTitulo,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(misNotas[index].getContenido),
                      Text(misNotas[index].getFechaHora),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _crearBoton() {
    return Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Nueva Nota',
                style: TextStyle(color: Colors.white),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            elevation: 0.0,
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: () {
              modal();
            }));
  }

  modal() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              elevation: 15.0,
              title: Text(
                "Nueva Nota",
                style: TextStyle(fontSize: 20.0),
              ),
              children: <Widget>[
                Container(
                  height: 300,
                  width: 200,
                  child: Column(
                    children: [
                      titulo(),
                      contenido(),
                      crearfecha(),
                      colores(),
                      SimpleDialogOption(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.0),
                          height: 20.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.pink[300]),
                          child: Center(
                            child: Text("Guardar"),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            misNotas.add(Nota(contenidoController.text,
                                tituloController.text, fecha));
                            contenidoController.text = "";
                            tituloController.text = "";
                            fecha = "";
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }

  Widget colores() {
    return Container(
      height: 50.0,
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
              onTap: () {
                setState(() {
                  colr = getColorAplicandoEstrategia(new ColorRojo());
                });
              },
              child: colorsitos(Colors.red)),
          GestureDetector(
              onTap: () {
                setState(() {
                  colr = getColorAplicandoEstrategia(new ColorAzul());
                });
              },
              child: colorsitos(Colors.blue)),
          GestureDetector(
              onTap: () {
                setState(() {
                  colr = getColorAplicandoEstrategia(new ColorAmarillo());
                });
              },
              child: colorsitos(Colors.yellow)),
          GestureDetector(
              onTap: () {
                setState(() {
                  colr = getColorAplicandoEstrategia(new ColorVerde());
                });
              },
              child: colorsitos(Colors.green)),
          GestureDetector(
              onTap: () {
                setState(() {
                  colr = getColorAplicandoEstrategia(new ColorRojo());
                });
              },
              child: colorsitos(Colors.pink)),
        ],
      ),
    );
  }

  getColorAplicandoEstrategia(ColorEstrategy estrategy) {
    return estrategy.getColor();
  }

  /*Color crearColor(String color) {
    Color colorsitodelista;
    switch (color) {
      case "Azul":
        {
          colorsitodelista = getColorAplicandoEstrategia(new ColorAzul());
        }
        break;

      case "Amarillo":
        {
          colorsitodelista = getColorAplicandoEstrategia(new ColorAzul());
        }
        break;
      case "Verde":
        {
          colorsitodelista = getColorAplicandoEstrategia(new ColorAzul());
        }
        break;
      case "Rosa":
        {
          colorsitodelista = getColorAplicandoEstrategia(new ColorAzul());
        }
        break;
      case "Rojo":
        {
          colorsitodelista = getColorAplicandoEstrategia(new ColorAzul());
        }
        break;
      default:
        break;
    }
    return colorsitodelista;
  }*/

  Widget colorsitos(Color color) {
    return Container(
      height: 30.0,
      width: 30.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0), color: color),
    );
  }

  Widget titulo() {
    return Container(
      // color: Colors.red[100],
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 5.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      child: TextField(
        style: TextStyle(fontSize: 9.0),
        decoration: InputDecoration(
          labelText: "Titulo",
          border: OutlineInputBorder(),
        ),
        controller: tituloController,
      ),
    );
  }

  Widget contenido() {
    return Container(
      // color: Colors.red[100],
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      child: TextField(
        maxLines: 2,
        style: TextStyle(fontSize: 9.0),
        decoration: InputDecoration(
          labelText: "Contenido",
          border: OutlineInputBorder(),
        ),
        controller: contenidoController,
      ),
    );
  }

  Widget crearfecha() {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: InputDecorator(
          decoration: InputDecoration(labelText: "Fecha", enabled: true),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(DateFormat.yMMMd().format(_dateSelected)),
              Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
            ],
          ),
        ),
      ),
    );
  }
}
