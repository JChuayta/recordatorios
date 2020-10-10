import 'package:flutter/material.dart';
import 'ColorEstrategy.dart';

class ColorVerde implements ColorEstrategy{
  @override
  Color getColor() {
    return Colors.green;
  }

}