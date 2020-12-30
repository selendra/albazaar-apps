import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'components/intro_slide.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController;
  //bool isPageCanChanged = true;
  PrefService _pref = PrefService();
  int currentIndex = 0;

  List<Widget> slidePage = [
    IntroSlide(
      title: 'Trade & Exchange',
      svgImage: 'images/undraw_Mobile_application.svg',
      description:
          'A Decentralized Marketplace that connect community of users together to trade and exchange goods and services freely, securely and fairly.',
    ),
    IntroSlide(
      title: 'Secured Transactions',
      svgImage: 'images/undraw_Mobile_application.svg',
      description:
          'The communication and transactiIons are done securely on Blockchain. Powered by Selendra Public Blockchain built with Substrates.',
    ),
    IntroSlide(
      title: 'Start Trading Now',
      svgImage: 'images/undraw_Mobile_application.svg',
      description:
          'A virtual market for goods and services exchange that empower community to take charge of their own goods and connect directly with buyers.',
    ),
  ];

  void onPageChange(int value) async {
    if (_pageController != null) {
      setState(() {
        currentIndex = value;
      });
      if (currentIndex > 2) {
      } else {
        await _pageController.animateToPage(value,
            duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: slidePage.length,
                onPageChanged: onPageChange,
                itemBuilder: (context, index) => slidePage[index],
              ),
              ReuseIndicator(currentIndex),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        nextskipButton(() {
                          _pref.saveString('isshow', 'seen');
                          Navigator.pushReplacementNamed(context, WelcomeView);
                        }, _lang.translate('skip')),
                        currentIndex >= 2
                            ? nextskipButton(() {
                                _pref.saveString('isshow', 'seen');
                                Navigator.pushReplacementNamed(
                                    context, WelcomeView);
                              }, _lang.translate('let_begin'))
                            : nextskipButton(() {
                                onPageChange(currentIndex + 1);
                              }, _lang.translate('next')),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nextskipButton(Function func, String title) {
    return FlatButton(
      onPressed: func,
      child: Text(
        title,
        style: TextStyle(color: kDefaultColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
