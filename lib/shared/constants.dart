import 'package:flutter/material.dart';

//style of input text field
const textInputDecoration = InputDecoration(
  //fillColor: Colors.orange,
  filled: true,
  labelStyle: TextStyle(color: Colors.lightGreenAccent),
  hintStyle: TextStyle(
    color: Colors.orange,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.amber, width: 2.0),
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
      bottom: Radius.circular(25.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightGreenAccent, width: 2.0),
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
      bottom: Radius.circular(25.0),
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
      bottom: Radius.circular(25.0),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2.0),
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(25.0),
      bottom: Radius.circular(25.0),
    ),
  ),
  errorStyle: TextStyle(
    color: Colors.amber,
  )
);

//style of app bar
const appBarDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: <Color>[Colors.orange, Colors.amberAccent],
  ),
);

//style of body
const bodyDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: <Color>[Colors.indigo, Colors.cyan],
  ),
);

//style of setting
const settingButtonDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(
        color: Colors.amber,
        width: 4.0
    ),
    right: BorderSide(
        color: Colors.amber,
        width: 4.0
    ),
  )
);

//style home button
const homeButtonDecoration = BoxDecoration(
  border: Border(
    right: BorderSide(
      color: Colors.indigo,
      width: 2.0
    )
  )
);




