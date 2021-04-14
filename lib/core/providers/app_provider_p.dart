import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/providers/add_product_provider.dart';
import 'package:albazaar_app/core/providers/guest_acc_p.dart';
import 'package:albazaar_app/core/providers/seller_provider.dart';
import 'package:albazaar_app/core/providers/shop_provider.dart';
import 'package:albazaar_app/core/providers/trx_history_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static List<SingleChildWidget> listProvider= [
    StreamProvider<ConnectivityStatus>(
      create: (context) => ConnectivityServices().streamController.stream,
    ),
    ChangeNotifierProvider<LangProvider>(
      create: (context) => LangProvider(),
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider<CartProvider>(
      create: (context) => CartProvider(),
    ),
    ChangeNotifierProvider<ProductsProvider>(
        create: (context) => ProductsProvider()),
    ChangeNotifierProvider<FavoriteProvider>(
      create: (context) => FavoriteProvider(),
    ),
    ChangeNotifierProvider<AddProductProvider>(
        create: (context) => AddProductProvider()),
    ChangeNotifierProvider<SellerProvider>(
        create: (context) => SellerProvider()),
    ChangeNotifierProvider<TrxHistoryProvider>(
        create: (context) => TrxHistoryProvider()),
    ChangeNotifierProvider<GuestAccProvider>(
      create: (context) => GuestAccProvider()),
    ChangeNotifierProvider<CategoriesModel>(create: (context) => CategoriesModel()),

    ChangeNotifierProvider<ShopProvider>(create: (context) => ShopProvider())
  ];
}