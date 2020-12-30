import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';

class MyQr extends StatefulWidget {
  @override
  _MyQrState createState() => _MyQrState();
}

class _MyQrState extends State<MyQr> {
  PageController _pageController;

  int currentIndex = 0;

  double viewportFraction = 0.8;

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
    _pageController = PageController(viewportFraction: viewportFraction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDefaultColor,
        elevation: 0,
        title: Text(
          AppLocalizeService.of(context).translate('recieve'),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: kDefaultColor,
          ),
          Container(
            child: PageView.builder(
              controller: _pageController,
              itemCount: wallets.length,
              onPageChanged: onPageChange,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 80),
                      child: ReuseQrCard(
                        image: wallets[index].logo,
                        title: wallets[index].title,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: BtnSocial(
                              () {}, AssetImage('images/avatar.png'))),
                    ),
                    ReuseIndicator(currentIndex),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
