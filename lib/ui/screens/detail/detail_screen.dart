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

  List<String> imgUrls = [];

  CartProvider _cartProvider;
  List<Product> _productByCategory;
  List<Product> _relatedProduct;
  bool isGuestAcc = false;

  void guestAccCheck() async {
    await StorageServices.fetchData(DbKey.guestAcc).then((value) {
      if (value != null){
        setState((){
          isGuestAcc = value;
        });
      }
    });
  }

  void fillSubImgWithThumbnail(){
    widget.product.subImageUrl.forEach((element) {
      print("Sub image $element");
      imgUrls.add(element);
    });
    print(imgUrls);
    setState((){});
  }

  @override
  initState(){
    imgUrls.add(widget.product.thumbnail);
    fillSubImgWithThumbnail();
    guestAccCheck();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // final Product productId = ModalRoute.of(context).settings.arguments;
    Provider.of<ProductsProvider>(context).findImgById(widget.product.id);
    
    _cartProvider = Provider.of<CartProvider>(context);

    _productByCategory = Provider.of<CategoriesModel>(context).getListProductCategory(widget.product.categoryName);
    _relatedProduct = Provider.of<CategoriesModel>(context).getRelatedProduct(widget.product.categoryName);

    // final loadedProduct = Provider.of<ProductsProvider>(context).findById(product[0].id);
    return Scaffold(
      body: widget.product == null ? Center(child: CircularProgressIndicator()) : Body(
        isGuestAcc: isGuestAcc,
        product: widget.product,
        cartProvider: _cartProvider,
        imgUrls: imgUrls,
        productByCategory: _productByCategory,
        relatedProduct: _relatedProduct
      ),
      bottomNavigationBar: GestureDetector(
        onTap: isGuestAcc == false ? null : () async {
          // For Guest Acc
          requestSignUpDialog(context);
        },
        child: BottomNavigationDetail(widget.product),
      )
    );
  }
}
