import 'package:flutter/material.dart';

final myButtonStyle = ButtonStyle(
    overlayColor: MaterialStateProperty.all(Colors.blue[200]),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white));
