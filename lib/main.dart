import 'package:barcelos/const.dart';
import 'package:barcelos/models/commandes.dart';
import 'package:barcelos/models/items.dart';
import 'package:barcelos/panier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<ItemsModel> itemsLocalList = [];
  final Set<ItemsModel> _panier = {};
  late Future<dynamic> futureItems;

  @override
  initState() {
    super.initState();
    futureItems = ItemsModel.fetchItems();
  }

  void ajouterAuPanier(Commandes commande) {
    bool alreadyAdded = false;
    Commandes? xElement;

    setState(() {

      for(var i = 0; i < Commandes.commandes.length; i++) {
        if(Commandes.commandes.elementAt(i).item == commande.item) {
          alreadyAdded = true;
          print('Already added');
          Commandes.commandes.elementAt(i).quantite =commande.quantite;
          // xElement = Commandes.commandes.elementAt(i);
        }
      }


      if(!alreadyAdded){
        Commandes.commandes.add(commande);
        print('Ajout au panier de ${commande.item.foodName}');
      } else {
        print('Update au panier de ${commande.item.foodName}');
      }

    });
  }

  void supprimerDuPanier(Commandes commande) {
    setState(() {
      if (Commandes.commandes.contains(commande)) {
        //_panier.remove(item);
        Commandes.commandes.add(commande);
        print('Suppresssion au panier de ${commande.item.foodName}');
      }
    });
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
      body: FutureBuilder<dynamic>(
        future: futureItems,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            itemsLocalList = ItemsModel.buildListItemsFromJson(snapshot.data['data']);
            return ListView(
              children: <Widget>[
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
                        color: Colors.black,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications),
                        color: Colors.black,
                      ),
                      /*Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    image: DecorationImage(
                        image: AssetImage('assets/avocado.png'),
                        fit: BoxFit.cover)),
              )*/
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text('Bienvenu',
                          style: TextStyle(
                              fontFamily: 'Futur',
                              fontWeight: FontWeight.bold,
                              color: AppStyle.premierChoix,
                              fontSize: 42.0)),
                      Text('Chez Barcelos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppStyle.premierChoix,
                              fontSize: 42.0)),
                      SizedBox(height: 20.0),
                      Text('Plats Populares',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0))
                    ],
                  ),
                ),
                const SizedBox(height: 7.0),
                Container(
                  height: 250.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _buildListItem(),
                  ),
                ),

                const SizedBox(height: 20.0),
                const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text('Nos Meilleurs',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0))),
                const SizedBox(height: 20.0),
                ..._buildNosMeilleurs(),
                const SizedBox(height: 20.0)
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Container(
            width: 250,
            height: 250,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 75.0,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          color: Color(0XCFFC3901),
        ),
        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home, color: Colors.white)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_outlined, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push((MaterialPageRoute(builder: (context) => PanierPage(onSuppressionDuPanier: supprimerDuPanier, onAjoutAuPanier: ajouterAuPanier,))));
              },
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_outline, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListItem() {
    List<Widget> inkWell = [];

    for (int i = 0; i < itemsLocalList.length; i++) {
      inkWell.add(InkWell(
          onTap: () {
            Navigator.of(context).push((MaterialPageRoute(
                builder: (context) => DetailsPage(
                    item: itemsLocalList[i],
                    onAjouterAuPanier: ajouterAuPanier))));
          },
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
              child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6.0,
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5.0)
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: 175.0,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Color(0xFFFC3901)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)))),
                      Hero(
                          tag: itemsLocalList[i].foodImage,
                          child: Container(
                            height: 175.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    NetworkImage(itemsLocalList[i].foodImage),
                                    fit: BoxFit.contain),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                          )),
                      Positioned(
                          top: 160.0,
                          right: 20.0,
                          child: Material(
                              elevation: 2.0,
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                child: const Center(
                                    child: Icon(Icons.favorite,
                                        color: Colors.red, size: 17.0)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white),
                              ))),
                      Positioned(
                          top: 190.0,
                          left: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(itemsLocalList[i].foodName,
                                  style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 14.0)),
                              const SizedBox(height: 3.0),
                              Container(
                                  width: 175.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: const <Widget>[
                                          Text(
                                            '4.9',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.grey,
                                                fontSize: 12.0),
                                          ),
                                          SizedBox(width: 3.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 12.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 12.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 12.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 12.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 12.0),
                                        ],
                                      ),
                                      Text(
                                          (itemsLocalList[i].foodPrice.round())
                                                  .toString() +
                                              ' FC',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              fontSize: 16.0)),
                                    ],
                                  ))
                            ],
                          ))
                    ],
                  )))));
    }

    return inkWell;
  }

  List<Widget> _buildNosMeilleurs() {
    List<Widget> nosMeilleurs = [];

    for (int i = itemsLocalList.length - 1; i >= 0; i--) {
      nosMeilleurs.add(InkWell(
          onTap: () {
            Navigator.of(context).push((MaterialPageRoute(
                builder: (context) => DetailsPage(
                    item: itemsLocalList[i],
                    onAjouterAuPanier: ajouterAuPanier))));
          },
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, bottom: 10.0, right: 20.0),
              child: Container(
                  height: 240.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6.0,
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5.0)
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          height: 175.0,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Color(0xFFFC3901)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)))),
                      Hero(
                          tag: itemsLocalList[i].foodName,
                          child: Container(
                            height: 175.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    NetworkImage(itemsLocalList[i].foodImage),
                                    fit: BoxFit.contain),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                          )),
                      Positioned(
                          top: 160.0,
                          right: 20.0,
                          child: Material(
                              elevation: 2.0,
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                child: const Center(
                                    child: Icon(Icons.favorite,
                                        color: Colors.red, size: 17.0)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.white),
                              ))),
                      Positioned(
                          top: 190.0,
                          left: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(itemsLocalList[i].foodName,
                                  style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 14.0)),
                              const SizedBox(height: 3.0),
                              Container(
                                  width: 290.0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: const <Widget>[
                                          Text(
                                            '4.9',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.grey,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(width: 3.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 14.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 14.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 14.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 14.0),
                                          Icon(Icons.star,
                                              color: Color(0XFFFC3901),
                                              size: 14.0),
                                        ],
                                      ),
                                      Text(
                                          itemsLocalList[i]
                                              .foodPrice
                                          .round()
                                              .toString() + ' FC',
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 18.0)),
                                    ],
                                  ))
                            ],
                          ))
                    ],
                  )))));
    }
    return nosMeilleurs;
  }
}
