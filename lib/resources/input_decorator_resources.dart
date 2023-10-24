import 'package:flutter/material.dart';

class InputDecoratorResources {
  final OutlineInputBorder enabledBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Colors.white54,
    ),
  );

  final OutlineInputBorder focusedBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Colors.white,
    ),
  );

  final errorBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Color.fromRGBO(229, 115, 115, 1),
    ),
  );

  final OutlineInputBorder focusedErrorBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Color.fromRGBO(229, 115, 115, 1),
    ),
  );
}
