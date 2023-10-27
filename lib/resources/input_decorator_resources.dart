import 'package:flutter/material.dart';

import 'colors_resources.dart';

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
    borderSide: BorderSide(
      color: ColorsResources().orangeLightColor,
    ),
  );

  final OutlineInputBorder focusedErrorBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: ColorsResources().orangeLightColor,
    ),
  );
}
