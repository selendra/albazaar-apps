import 'package:flutter/material.dart';
import 'package:albazaar_app/all_export.dart';
import 'package:provider/provider.dart';
import 'package:albazaar_app/core/components/card_c.dart';

class RelatedProduct extends StatelessWidget {

  List<Product> relatedProduct = [];

  String currentProductId;

  String category;

  RelatedProduct({this.category, this.currentProductId});

  @override
  Widget build(BuildContext context) {

    relatedProduct = Provider.of<CategoriesModel>(context).getCategories(category);

    print("My length ${relatedProduct.length ?? ''}" );
    
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: relatedProduct.length,
      shrinkWrap: true,
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 10,
      //   childAspectRatio: 0.75,
      // ),
      itemBuilder: (context, index) {

        // if (currentProductId == relatedProduct[index].id) print(index.toString()+"INDex");

        print("My length after ${relatedProduct.length ?? ''}" );
        // Remove Current Reviewing Product From Ralated List && If Still have More Product Else Not Display
        return Stack(
          children:  [
            
            if (index == 0) ReuseItemCard(
              product: relatedProduct[index],
              mLeft: 19,
            ),

            if (index > 0 && index < relatedProduct.length) ReuseItemCard(
              product: relatedProduct[index],
              mLeft: 0,
            ),

            Positioned(
              left: (index == 0) ? 19 : 0 , top: 0,
              child: Consumer<CartProvider>(
                builder: (context, value, widgets){
                  return GestureDetector(
                    onTap: (){
                      value.addCart(relatedProduct[index].id, relatedProduct[index].thumbnail, relatedProduct[index].name, relatedProduct[index].price, relatedProduct[index].orderQty);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: MyText(text: 'Added ${relatedProduct[index].name} into cart', color: AppColors.white, textAlign: TextAlign.left,))
                      );
                    },
                    child: MyCard(
                      bTopRight: 0,
                      bBottomLeft: 0,
                      hexaColor: AppColors.secondary,
                      width: 50, height: 45,
                      child: Center(
                        child: SvgPicture.asset('assets/icons/cart.svg', color: Colors.white, height: 24, width: 24),
                      ),
                    ),
                  );
                },
              )
            )
          ],
        );
      }
      // ChangeNotifierProvider.value(
      //   value: listProducts[index],
      //   child: ReuseItemCard(
      //     product: listProducts[index],
      //   ),
      // ),
    );
  }
}
