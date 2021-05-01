import 'package:albazaar_app/all_export.dart';
import 'package:latlong/latlong.dart';

class LocationMarker {

  final double lat; final double long;
  
  List<Marker> markers = [];

  LocationMarker({
    this.lat,
    this.long
  });

  List<Marker> marker (){
    markers = <Marker>[
      Marker(
        width: 80,
        height: 80,
        anchorPos: AnchorPos.align(AnchorAlign.top),
        point: LatLng(lat, long),
        builder: (ctx) => IconButton(
          icon: Icon(Icons.location_on),
          onPressed: () {
            showBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(kDefaultRadius * 3),
                ),
              ),
              context: ctx,
              builder: (context) => Container(
                height: MediaQuery.of(ctx).size.height / 3,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(
                        kDefaultRadius * 3,
                      ),
                      topRight: const Radius.circular(kDefaultRadius * 3),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.drag_handle,
                          color: kDefaultColor,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Consumer<ProductsProvider>(
                        builder: (context, value, child) => Container(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: value.imageList.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              width: MediaQuery.of(context).size.width / 2,
                              height: 50.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 5.0,
                                        blurRadius: 5.0,
                                      )
                                    ],
                                  ),
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(value.imageList[0].url),
                                    placeholder: AssetImage('assets/loading.gif'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        hoverColor: Colors.grey,
                        title: Text(
                          'Bonchay Ouk',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text('st5 toul sangke phnom penh'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          color: Colors.red,
          iconSize: 40,
        ),
      )
    ];
    return markers;
  }
}