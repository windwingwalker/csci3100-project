import 'package:csci3100/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bodyDecoration,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.amber,
          size: 50.0,
        ),
      ),
    );
  }
}
