import 'package:selendra_marketplace_app/models/acc_balance.dart';

class Wallet {
  String title;
  String amount;

  Wallet(this.title, this.amount);

}
List<Wallet> wallets = [
  Wallet(
      'Selendra (SEL)',
      mBalance[1].balance,
  ),
  Wallet(
      'Maker Dai',
      '0.00'
  ),
  Wallet(
      'Ethereum',
      '000000'
  )
];