import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:selendra_marketplace_app/ui/reuse_widget/responsive_widget.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).mUser;
    var size = MediaQuery.of(context).size.width * 0.15;

    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            )
          ]),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
                    Padding(
                        child: Image.asset('images/icon_launcher.png',
                            width: 30, height: 30),
                        padding: EdgeInsets.only(right: 5)),
                    Text(
                      'SELENDRA',
                      style: TextStyle(
                        color: kDefaultColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width * 0.3,
              child: Card(
                elevation: 1.0,
                shape: kDefaultShape,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // GestureDetector(
                      //   child: Icon(
                      //     Icons.search,
                      //     color: Colors.black54,
                      //   ),
                      //   onTap: () {},
                      // ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search..."),
                          onSubmitted: (String place) {},
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => SettingsScreen()));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 30.0,
                    color: kDefaultColor,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: user.profileImg == null
                            ? AssetImage('images/avatar.png')
                            : NetworkImage(user.profileImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
