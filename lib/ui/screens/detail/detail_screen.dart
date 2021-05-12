import 'package:flutter/material.dart';
import 'package:albazaar_app/ui/screens/detail/components/body.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/all_export.dart';
import 'components/bottom_navigation_detail.dart';

class DetailScreen extends StatefulWidget {

  final Product product;

  DetailScreen({
    this.product
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  List<String> _listImage = [];
  CartProvider _cartProvider;
  List<Product> _productByCategory;
  bool isGuestAcc = false;

  void guestAccCheck() async {
    await StorageServices.fetchData(DbKey.guestAcc).then((value) {
      print(value);
      if (value != null){
        setState((){
          isGuestAcc = value;
        });
      }
    });
  }

  @override
  initState(){
    guestAccCheck();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final Product productId = ModalRoute.of(context).settings.arguments;
    Provider.of<ProductsProvider>(context).findImgById(widget.product.id);
    _listImage = Provider.of<ProductsProvider>(context).url;
    
    _cartProvider = Provider.of<CartProvider>(context);
    _productByCategory = Provider.of<CategoriesModel>(context).fillProductByCategories(widget.product.categoryName);

    // final loadedProduct = Provider.of<ProductsProvider>(context).findById(product[0].id);
    return Scaffold(
      body: widget.product == null ? Center(child: CircularProgressIndicator()) : Body(
        isGuestAcc: isGuestAcc,
        product: widget.product,
        listImage: _listImage,
        cartProvider: _cartProvider,
        productByCategory: _productByCategory
      ),
      bottomNavigationBar: GestureDetector(
        onTap: isGuestAcc == false ? null : () async {
          requestSignUpDialog(context);
        },
        child: BottomNavigationDetail(widget.product),
      )
    );
  }
}
