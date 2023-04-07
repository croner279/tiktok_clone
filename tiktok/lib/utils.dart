import 'package:flutter/material.dart';

bool isDarkmode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;
