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

  bool dispsseAnimation = false;

  List<Map<String, dynamic>> images = [
    {'name': 'Vegetables', 'image': 'assets/categories/vegetable.png'},
    {'name': 'Electronics', 'image': 'assets/categories/koompi.png'},
    {'name': 'Books', 'image': 'assets/categories/book.png'},
  ];

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
              itemCount: images.length,
              itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  category = images[index]['name'];
                  onTapCategoy();
                  print(animationController.status);
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
                              images[index]['image']
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
                            text: images[index]['name'],
                            color: AppColors.white
                          ),
                        ),
                      ],
                    )
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
