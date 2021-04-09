import 'package:albazaar_app/core/providers/guest_acc_p.dart';
import 'package:albazaar_app/ui/screens/home/components/categories_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ProductCategories extends StatefulWidget {

  final Function onTapTab;

  ProductCategories({
    this.onTapTab,
  });

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<ProductCategories> with TickerProviderStateMixin {

  ScrollController _scrollController = ScrollController();

  Animation<Offset> animation;
  AnimationController animationController;

  final double cPadding = 10;

  final double padding = 16;

  String category = '';
  
  bool dispsseAnimation = false;

  List<Product> listProduct;
  List<Product> productCategories;

  ProductsProvider productsProvider;
  CategoriesModel _categoriesModel;

  void onTapCategoy(){
    productCategories.clear();
    if (category == 'Vegetable'){
      productCategories = _categoriesModel.vegetableList;
    } else if (category == 'Fruit') {
      productCategories = _categoriesModel.fruitList;
    } else if (category == 'Fish'){
      productCategories = _categoriesModel.fishList;
    } else if (category == 'Meat'){
      productCategories = _categoriesModel.meatList;
    } else if (category == 'Cereal'){
      productCategories = _categoriesModel.carealList;
    } else if (category == 'Others'){
      productCategories = _categoriesModel.othersList;
    }
    print(category);
    print("Categoires $productCategories");
    // _scrollController.jumpTo(0);
    animationController.forward();
  }

  void popAnmation(){
    animationController.reverse();
  }

  @override
  initState(){
    _scrollController = ScrollController();
    listProduct = [];
    category = '';
    productCategories = [];

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOutCubic)
    )..addListener(() {
      setState((){});
    });

    super.initState();
  }

  @override
  void dispose(){
    animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _categoriesModel = Provider.of<CategoriesModel>(context);
    listProduct = Provider.of<CategoriesModel>(context).listProduct;
    print("My  product ${_categoriesModel.listProduct}");
    return Stack(
      children: [
        
        RefreshIndicator(
          onRefresh: () {},
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _categoriesModel.category.length,
            itemBuilder: (context, index){
              return MyPadding(
                pLeft: 0, pRight: 0,
                pBottom: index == _categoriesModel.category.length -1 ? 18 : 0,
                child: GestureDetector(
                  onTap: (){
                    category = _categoriesModel.category[index].title;
                    onTapCategoy();
                  },
                  child: MyCard(
                    colorOpacity: 0.0,
                    pLeft: 16, pRight: 16, pBottom: 16,
                    height: 171,
                      child: Stack(
                        children: [
                          MyCard(
                            colorOpacity: 0.0,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                _categoriesModel.category[index].img
                              )
                            ),
                          ),

                          MyCard(
                            width: double.infinity,
                            height: double.infinity,
                            colorOpacity: 0.4,
                            hexaColor: AppColors.lowBlack,
                            alignChild: Alignment.center,
                            child: MyText(
                              text: _categoriesModel.category[index].title,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
              );
            }
          ),   
        ),
        SlideTransition(
          position: animation,
          child: Opacity(
            opacity: animation.value.dx == 1 ? 0 : 1, // Prevent remain UIs blink When tap Another Tabbar
            child: CategoriesBuider(
              scrollController: _scrollController,
              productCategories: productCategories,
              category: category,
              onTapCategoy: onTapCategoy,
              popAnmation: popAnmation
            ),
          ),
        ),
      ],
    );
  }
}
