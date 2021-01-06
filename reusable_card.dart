import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({
    this.colour,
    this.cardChild,
    this.onPress,
    this.height,
    this.width,
  });

  final Color colour;
  final Widget cardChild;
  final Function onPress;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        child: ClipRRect(
          child: cardChild,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black),
        ),
      ),
    );
  }
}