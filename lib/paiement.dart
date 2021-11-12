import 'package:flutter/material.dart';
import 'package:barcelos/const.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shimmer/shimmer.dart';
import 'package:barcelos/models/commandes.dart';

class PaiementPage extends StatefulWidget {
  @override
  _PaiementPageState createState() => _PaiementPageState();
}

class _PaiementPageState extends State<PaiementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 75,
            title: const Text('Paiement',
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
          Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Choisissez un mode de paiement',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0)),
                ],
              )),
          const Divider(),
          Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(
                                  context, Commandes.postCommandes()),
                        );
                      },
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 6.0,
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5.0)
                              ],
                            image: const DecorationImage(
                                image: AssetImage('assets/orange-money-logo.jpg'),
                              fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(
                                  context, Commandes.postCommandes()),
                        );
                      },
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 6.0,
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5.0)
                            ],
                            image: const DecorationImage(
                                image: AssetImage('assets/mpesa.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(
                                  context, Commandes.postCommandes()),
                        );
                      },
                      child: Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 6.0,
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5.0)
                            ],
                            image: const DecorationImage(
                                image: AssetImage('assets/AirtelMoney.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ),
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
                  child: 'Choisir un autre moyen'
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

  Widget _buildPopupDialog(BuildContext context, Future<dynamic> ordersPosted) {
    return AlertDialog(
      title: const Text('Envoie de Commande'),
      content: FutureBuilder<dynamic>(
          future: ordersPosted,
          builder: (context, ss) {
            // ss.data.status != true
            if (ss.hasData) {
              Commandes.emptyCommandesList();
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Center(
                      child: Icon(
                        Icons.check_circle_outline,
                        color: Vx.green300,
                        size: 60,
                      ),
                    ),
                  ),
                  //'${ss.data}'.text.xl2.makeCentered(),
                  'Votre commande a été envoyéé'.text.xl2.makeCentered(),
                ],
              );
            } else if (ss.hasError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Vx.red300,
                        size: 60,
                      ),
                    ),
                  ),
                  // '${ss.error}'.text.xl2.makeCentered(),
                  'Envoie de la commande a échoué'.text.xl2.makeCentered(),
                ],
              );
            }

            return Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
      actions: <Widget>[
        Container(
          height: 50,
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: AppStyle.premierChoix),
            onPressed: () => {Navigator.of(context).pop('/')},
            child: 'Fermer'.text.xl.make().centered(),
          ),
        ),
      ],
    );
  }
}
