
import 'dart:ui';
import 'package:flutter/material.dart';
import 'ColorEstrategy.dart';

class ColorAmarillo implements ColorEstrategy{
  @override
  Color getColor() {
    return Colors.yellow;
  }

}
