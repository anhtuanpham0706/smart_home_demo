import 'package:flutter/material.dart';




class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.image,
  }) : super(key: key);
  final String  image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image,),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}