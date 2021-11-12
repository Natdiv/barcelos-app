import 'package:barcelos/addresse_livraison.dart';
import 'package:barcelos/const.dart';
import 'package:barcelos/models/commandes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';



class CommandePage extends StatefulWidget {
  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {

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
            title: const Text('Ma commande',
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
              children: <Widget>[
                const Text('Total à payer',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0)),
                Text(Commandes.getTotal().round().toString() + ' FC',
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ],
            )
          ),
          const Divider(),
          (Commandes.commandes.isEmpty)
              ? Expanded(
              child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 100,
                          color: Color(0X3F000000),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        'Votre Panier est vide'
                            .text
                            .gray400
                            .xl2
                            .medium
                            .makeCentered()
                      ],
                    ),
                  )))
              : Expanded(
              child: Padding(
                padding: const EdgeInsets.only(),
                child: ListView.builder(
                  itemCount: Commandes.commandes.length,
                  itemBuilder: (context, index) {
                    final commande = Commandes.commandes.elementAt(index);
                    return ListTile(
                      title: Text(
                        commande.item.foodName,
                        style: TextStyle(),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(commande.item.foodPrice.round().toString() +
                              ' FC'),
                          Text(commande.quantite.toString() + ' Pieces'),
                        ],
                      ),

                    );
                  },
                ),
              )),
          Container(
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
              height: 50,
              padding: const EdgeInsets.all(0),
              /*margin: EdgeInsets.symmetric(horizontal: AppColors.paddingh),*/
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppStyle.premierChoix, elevation: 0),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return AdresseLivraisonPage();
                    }),
                  )
                },
                child: Shimmer.fromColors(
                  baseColor: Vx.gray200,
                  highlightColor: Vx.gray50,
                  enabled: true,
                  child: 'Valider la commande'
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
