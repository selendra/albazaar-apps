import 'package:selendra_marketplace_app/core/models/acc_balance.dart';
import 'package:selendra_marketplace_app/all_export.dart';

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
    'images/icon_launcher.png',
  ),
  Wallet('Maker Dai', '0.00', 'images/maker_dai.png'),
  Wallet('Ethereum', '000000', 'images/etherium.jpg')
];
