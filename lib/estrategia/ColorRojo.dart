import 'package:flutter/material.dart';
import 'ColorEstrategy.dart';

class ColorRojo implements ColorEstrategy{
  @override
  Color getColor() {
    return Colors.red;
  }

}