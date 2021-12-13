import 'package:flutter/material.dart';

class GradientAnimation extends StatelessWidget {
  const GradientAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1 / 2,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0),
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(1),
            Colors.white.withOpacity(1),
          ])),
    );
  }
}
