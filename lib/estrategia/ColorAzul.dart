
import 'package:flutter/material.dart';
import 'ColorEstrategy.dart';

class ColorAzul implements ColorEstrategy{
  @override
  Color getColor() {
    return Colors.blue;
  }
}