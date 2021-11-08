import 'package:barcelos/const.dart';
import 'package:barcelos/models/commandes.dart';
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
            ],
            title: const Text('Adresse de livraison',
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
          const SizedBox(height: 10.0),
          Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Adresse de livraison',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0)),
                  Text('Lubumbashi',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0)),
                ],
              )),
          const Divider(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 15.0,
              ),
            ),
          )),
          Container(
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
              height: 50,
              padding: const EdgeInsets.all(0),
              /*margin: EdgeInsets.symmetric(horizontal: AppColors.paddingh),*/
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: AppStyle.premierChoix, elevation: 0),
                onPressed: () => {},
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
        ],
      ),
    );
  }
}
