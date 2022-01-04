import 'package:flutter/material.dart';

Future nav(
  context,
  widget,
) {
  return Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => widget,
  ));
}

Future navWithReplacement(context, widget) {
  return Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => widget,
  ));
}

Future navWithReplaceAll(context, widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => widget,
    ),
    (route) => false,
  );
}
