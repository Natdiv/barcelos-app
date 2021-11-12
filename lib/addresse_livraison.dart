import 'package:barcelos/const.dart';
import 'package:barcelos/main.dart';
import 'package:barcelos/models/commandes.dart';
import 'package:barcelos/paiement.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class AdresseLivraisonPage extends StatefulWidget {
  @override
  _AdresseLivraisonPageState createState() => _AdresseLivraisonPageState();
}

class _AdresseLivraisonPageState extends State<AdresseLivraisonPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(-11.66612501551343, 27.48446737307677);
  late LatLng myPosition;
  bool isMyPositionSelected = false;

  Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onTap(LatLng latLng) {
    setState(() {
      myPosition = latLng;
      isMyPositionSelected = true;
      Marker maker = Marker(
          markerId: const MarkerId('destination'),
          alpha: 1.0,
          position: myPosition,
          onDrag: _didMyPositionChange);
      markers = {maker};
      print(latLng);
    });
  }

  void _didMyPositionChange(LatLng latLng) {
    myPosition = latLng;
    print("My Position Changed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 0,
        backgroundColor: const Color(0XFFFFFFFF),
        child: ListView(
          children: [DrawerHeader(child: Container())],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 75,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.location_on,
                  size: 28,
                  color: Color(0XAA000000),
                ),
                color: Colors.black,
              ),
            ],
            title: const Text('Indiquez l\'adresse',
                style: TextStyle(
                    fontFamily: 'Futur',
                    fontWeight: FontWeight.bold,
                    color: AppStyle.premierChoix,
                    fontSize: 24.0)),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  markers: markers,
                  onTap: _onTap,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 14.0,
                  ),
                ),
                (!isMyPositionSelected) ? Container() : Positioned(
                  child: Container(
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      height: 50,
                      padding: const EdgeInsets.all(0),
                      /*margin: EdgeInsets.symmetric(horizontal: AppColors.paddingh),*/
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppStyle.premierChoix, elevation: 0),
                        onPressed: () {
                          Commandes.lat = myPosition.latitude;
                          Commandes.long = myPosition.longitude;
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return PaiementPage();
                            })
                          );
                          /*showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(
                                    context, Commandes.postCommandes()),
                          );*/
                        },
                        child: Shimmer.fromColors(
                          baseColor: Vx.gray200,
                          highlightColor: Vx.gray50,
                          enabled: true,
                          child: 'Valider cette adresse'
                              .text
                              .xl2
                              .medium
                              .semiBold
                              .make()
                              .centered(),
                        ),
                      )),
                  bottom: 0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
