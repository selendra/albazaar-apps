import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class MyQr extends StatefulWidget {
  @override
  _MyQrState createState() => _MyQrState();
}

class _MyQrState extends State<MyQr> {
  PageController _pageController;

  int currentIndex = 0;

  void onPageChange(int value) async {
    if (_pageController != null) {
      setState(() {
        currentIndex = value;
      });
      print(value);
      if (currentIndex > 2) {
        print('final');
      } else {
        await _pageController.animateToPage(value,
            duration: Duration(milliseconds: 400), curve: Curves.easeOut);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem('Public Key', context),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: kDefaultColor,
          ),
          PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: onPageChange,
            itemBuilder: (context, index) => Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 90),
                    child: ReuseQrCard()),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin: const EdgeInsets.only(top: 60),
                      child: BtnSocial(() {}, AssetImage('images/avatar.png'))),
                ),
                ReuseIndicator(currentIndex),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
