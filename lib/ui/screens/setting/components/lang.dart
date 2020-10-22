import 'package:flutter/material.dart';
import 'package:selendra_marketplace_app/all_export.dart';
import 'package:provider/provider.dart';

class Lang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<LangProvider>(context);
    var _lang = AppLocalizeService.of(context);
    return Scaffold(
      appBar: ReuseSimpleAppBar.getItem(_lang.translate('language'), context),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Card(
              shape: kDefaultShape,
              elevation: 1,
              child: ListTile(
                onTap: () {
                  data.setLocal('EN', context);
                },
                title: Text(_lang.translate('english')),
                leading: Image.network(
                  engFlag,
                  width: 50,
                  height: 50,
                ),
                trailing: Consumer<LangProvider>(
                  builder: (context, value, child) =>
                      value.lang == 'EN' || value.lang == 'US'
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
                title: Text(_lang.translate('khmer')),
                leading: Image.network(
                  khFlag,
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
