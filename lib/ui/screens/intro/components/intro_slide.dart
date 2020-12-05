import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroSlide extends StatelessWidget {
  final String svgImage;
  final String title;
  final String description;

  IntroSlide({this.svgImage, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          SvgPicture.asset(
            svgImage,
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.2,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              description,
              style: TextStyle(
                height: 1.5,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.7,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
