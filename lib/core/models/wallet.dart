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
    'assets/icon_launcher.png',
  ),
  Wallet('Maker Dai', '0.00', 'assets/maker_dai.png'),
  Wallet('Ethereum', '000000', 'assets/etherium.jpg')
];
