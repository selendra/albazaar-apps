import 'package:selendra_marketplace_app/models/acc_balance.dart';

class Wallet {
  String title;
  String amount;
  String logo;

  Wallet(this.title, this.amount,this.logo);

}
List<Wallet> wallets = [
  Wallet(
      'Selendra (SEL)',
      mBalance[1].balance,
      'images/logo.png',
  ),
  Wallet(
      'Maker Dai',
      '0.00',
      'images/maker_dai.png'
  ),
  Wallet(
      'Ethereum',
      '000000',
      'images/etherium.jpg'
  )
];