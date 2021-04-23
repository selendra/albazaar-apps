import 'package:albazaar_app/core/models/acc_balance.dart';
import 'package:albazaar_app/all_export.dart';

class Wallet{
  String title;
  String amount;
  String logo;

  Wallet(this.title, this.amount, this.logo);
}

final List<Wallet> wallets = [
  Wallet(
    'Selendra (SEL)',
    '${mBalance.data.balance}',
    'assets/sel_logo.svg',
  ),
  Wallet('Binance Smart Chain (BNB)', '0.0', 'assets/bnb.svg'),
  Wallet('Ethereum', '0.0', 'assets/etherium.jpg')
];
