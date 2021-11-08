import 'package:barcelos/commande.dart';
import 'package:barcelos/const.dart';
import 'package:barcelos/models/commandes.dart';
import 'package:barcelos/models/items.dart';
import 'package:flutter/material.dart';


class DetailsPage extends StatefulWidget {
  final ItemsModel item;
  final AjouterAuPanierCallback onAjouterAuPanier;

  DetailsPage({required this.item, required this.onAjouterAuPanier});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int quantite = 1;
  double total = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final snackBar = SnackBar(
    content: const Text('Plat ajouté au panier', style: TextStyle(fontSize: 18),),
    duration: const Duration(milliseconds: 2000),
    padding: const EdgeInsets.symmetric(
      horizontal: 10.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    action: SnackBarAction(
      label: 'Annuler',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    // total = widget.foodPrice;
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(height: 300.0),
              Container(
                height: 200.0,
                decoration: const BoxDecoration(
                    /*image: DecorationImage(
                        image: AssetImage('assets/green.jpg'),
                        fit: BoxFit.cover),*/
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[AppStyle.premierChoix, Color(0X0FFC3901)],
                      tileMode: TileMode.repeated,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100.0),
                        bottomRight: Radius.circular(100.0))),
              ),
              Positioned(
                  top: 50.0,
                  left: (MediaQuery.of(context).size.width / 2) - 125,
                  child: Hero(
                      tag: widget.item.foodImage,
                      child: Container(
                        height: 250.0,
                        width: 250.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(widget.item.foodImage),
                                fit: BoxFit.cover)),
                      ))),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  color: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.item.foodName,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10.0),
                Row(
                  children: const <Widget>[
                    Text(
                      '4.9',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey,
                          fontSize: 17.0),
                    ),
                    SizedBox(width: 10.0),
                    Icon(Icons.star, color: AppStyle.premierChoix, size: 16.0),
                    Icon(Icons.star, color: AppStyle.premierChoix, size: 16.0),
                    Icon(Icons.star, color: AppStyle.premierChoix, size: 16.0),
                    Icon(Icons.star, color: AppStyle.premierChoix, size: 16.0),
                    Icon(Icons.star, color: AppStyle.premierChoix, size: 16.0),
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.item.foodPrice.round().toString() + ' FC',
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 17.0),
                      ),
                      Container(
                          width: 125.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: const Color(0X2FFC3901)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    color: AppStyle.premierChoix),
                                onPressed: () {
                                  setState(() {
                                    if (!(quantite == 1)) {
                                      quantite--;
                                      total = quantite * widget.item.foodPrice;
                                    }
                                  });
                                },
                              ),
                              Text(
                                quantite.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20.0,
                                    color: AppStyle.premierChoix),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle,
                                    color: AppStyle.premierChoix),
                                onPressed: () {
                                  setState(() {
                                    quantite++;
                                    total = quantite * widget.item.foodPrice;
                                  });
                                },
                              )
                            ],
                          ))
                    ]),
                const SizedBox(height: 10.0),
                const Text('Description',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16.0,
                        color: Colors.black)),
                const SizedBox(height: 10.0),
                Container(
                  child: const Text(
                    'Cet aliment léger cuisiné à ici chez nous est faible en sel et en huile avec une nutrition équilibrée,'
                    'sélectionné à partir d\'ingrédients de haute qualité. Cette nourriture délicieuse peut-être votre meilleur choix sain.',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Total à payer :',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          (total == 0)
                              ? widget.item.foodPrice.round().toString() + ' FC'
                              : total.round().toString() + ' FC',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                    widget.onAjouterAuPanier(
                        Commandes(item: widget.item, quantite: quantite));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    print('Ajouter au Panier...');
                  },
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppStyle.premierChoix,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'Ajouter au Panier',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push((MaterialPageRoute(
                        builder: (context) => CommandePage())));
                  },
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppStyle.premierChoix,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            'Passer la Commande',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 17.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //const SizedBox(height: 5.0),
              ],
            ),
          )
        ],
      ),
    );
  }
}
