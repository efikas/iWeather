import 'package:flutter/material.dart';

class Forcast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        // color: Colors.red,
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade500,
                Colors.blue.shade100
              ]
            ),
          ),
      ),
      clipper: InvertedCircleClipper(),
    );;
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return new Path()
      ..addOval(new Rect.fromCircle(
          center: new Offset(size.width / 2,  - size.width),
          radius: size.width * 2));
      // ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      // ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}