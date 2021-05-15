import 'package:albazaar_app/all_export.dart';
import 'package:albazaar_app/core/components/widget_builder.dart';
import 'package:albazaar_app/ui/screens/detail/components/interact_view.dart';

class DetailAppBar extends StatelessWidget{

  final String image;
  
  final int selected;

  final String productId;

  final List<String> listImage;

  final Function onChangeImage;

  DetailAppBar({
    this.image,
    this.selected,
    this.productId,
    this.listImage,
    this.onChangeImage
  });

  Widget build(BuildContext context){
    return SliverAppBar(
      elevation: 0,
      iconTheme: IconThemeData(
        color: kDefaultColor,
      ),
      leading: Container(),
      toolbarHeight: 70,
      expandedHeight: MediaQuery.of(context).size.height * 0.5,
      floating: true,
      pinned: true,
      primary: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Hero(
              tag: "$productId",
              child: SizedBox(
                child: Consumer<ProductsProvider>(
                  builder: (context, value, child) => Carousel(
                    onImageChange: (i,j){
                      onChangeImage(j);
                    },
                    autoplay: false,
                    dotSpacing: 15.0,
                    dotColor: Colors.transparent,
                    dotBgColor: Colors.transparent,
                    dotIncreasedColor: Colors.transparent,
                    indicatorBgPadding: 10.0,
                    borderRadius: true,
                    animationCurve: Curves.decelerate,
                    // moveIndicatorFromBottom: 200.0,
                    noRadiusForIndicator: true,
                    boxFit: BoxFit.cover,
                    images: List.generate(
                      value.url.isEmpty ? 1 : value.url.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InteractView(image),
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: image,
                            placeholder: (context, str){
                              return Image.asset('assets/loading.gif');
                            },
                          ),
                          // child: FadeInImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage(
                          //       value.url.isNotEmpty
                          //           ? value.url[index]
                          //           : widget.product.thumbnail,
                          //     ),
                          //     placeholder:
                          //         AssetImage('assets/loading.gif')),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: (MediaQuery.of(context).size.width/2) - (25.0 * listImage.length),
              bottom: 20,
              child: SizedBox(
                height: 50,
                width: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listImage.length,
                  itemBuilder: (context, i){
                    return ListWidgetBuilder.imageRowBuilder(
                      context: context, 
                      image: listImage[i],
                      selected: selected,
                      index: i,
                      onPressed: (){
                        onChangeImage(i);
                      }
                    );
                  }
                )
              )
            )
          ],
        ),
      ),
    );
  }
}