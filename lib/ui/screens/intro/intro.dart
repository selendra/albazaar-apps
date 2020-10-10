import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  PageController _pageController = PageController();
  bool isPageCanChanged = true;
  int currentIndex;

  void onPageChange(int value) async {
    if (_pageController != null) {
      isPageCanChanged = false;
      currentIndex = value;
      await _pageController.animateToPage(value,
          duration: Duration(milliseconds: 400), curve: Curves.easeOut);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          if (isPageCanChanged) {
            currentIndex = value;
            onPageChange(value);
          }
        },
        children: [
          Container(
            color: kDefaultColor,
            child: Column(
              children: [
                SvgPicture.asset('images/undraw_Mobile_application.svg'),

                //Text('Welcome to selendra'),
              ],
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Column(
              children: [
                SvgPicture.asset('images/undraw_Mobile_application.svg'),
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          print('back');
                          onPageChange(currentIndex - 1);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                //Text('Welcome to selendra'),
              ],
            ),
          ),
          Container(
            color: Colors.red,
            child: Column(
              children: [
                SvgPicture.asset('images/undraw_Mobile_application.svg'),
                //Text('Welcome to selendra'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
