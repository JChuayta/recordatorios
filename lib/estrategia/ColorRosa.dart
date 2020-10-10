import 'package:flutter/material.dart';
import 'ColorEstrategy.dart';

class ColorRosa implements ColorEstrategy{
  @override
  Color getColor() {
    return Colors.pink;
  }

}