import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class Lang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<LangProvider>(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(
          AppLocalizeService.of(context).translate('language'), context),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              shape: kDefaultShape,
              elevation: 1,
              child: ListTile(
                onTap: () {
                  data.setLocal('EN', context);
                },
                title:
                    Text(AppLocalizeService.of(context).translate('english')),
                leading: Image.network(
                  'https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/1200px-Flag_of_the_United_Kingdom.svg.png',
                  width: 50,
                  height: 50,
                ),
                trailing: Consumer<LangProvider>(
                  builder: (context, value, child) => value.lang == 'EN'
                      ? Icon(
                          Icons.check_circle,
                          color: kDefaultColor,
                        )
                      : Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            Card(
              shape: kDefaultShape,
              elevation: 1,
              child: ListTile(
                onTap: () {
                  data.setLocal('KH', context);
                },
                title: Text(AppLocalizeService.of(context).translate('khmer')),
                leading: Image.network(
                  'https://cdn.webshopapp.com/shops/94414/files/53596372/cambodia-flag-image-free-download.jpg',
                  width: 50,
                  height: 50,
                ),
                trailing: Consumer<LangProvider>(
                  builder: (context, value, child) => value.lang == 'KH'
                      ? Icon(
                          Icons.check_circle,
                          color: kDefaultColor,
                        )
                      : Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
