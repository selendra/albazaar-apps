import 'package:albazaar_app/core/providers/guest_acc_p.dart';
import 'package:albazaar_app/ui/screens/home/components/categories_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';

class ProductCategories extends StatefulWidget {

  final TabController tabController;

  final Function onTapTab;
  final Function refresh;

  ProductCategories({
    this.tabController,
    this.onTapTab,
    this.refresh
  });

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<ProductCategories> with TickerProviderStateMixin {

  Animation<Offset> animation;
  AnimationController animationController;

  final double cPadding = 10;

  final double padding = 16;

  String category;

  CategoriesModel _categoriesModel = CategoriesModel.init();
  
  bool dispsseAnimation = false;

  ProductsProvider productsProvider;

  void onTapCategoy(){
    animationController.forward();
  }

  void popAnmation(){
    animationController.reverse();
  }

  @override
  initState(){
    category = '';

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
    print("Hello dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productsProvider = Provider.of<ProductsProvider>(context);
    List<Product> listProduct = Provider.of<GuestAccProvider>(context).getProducts;
    return Stack(
      children: [
        
        RefreshIndicator(
          onRefresh: widget.refresh,
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
