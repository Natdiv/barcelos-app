import 'package:barcelos/models/items.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Commandes {

  final ItemsModel item;
  int quantite;

  Commandes({required this.item, required this.quantite});

  static Set<Commandes> commandes = {};
  static var lat = 0.0, long = 0.0;
  static String remoteUrl = 'https://baarcelosh.000webhostapp.com';
  static String localUrl = 'http://192.168.43.112';

  static void emptyCommandesList(){
    commandes.clear();
    lat = 0.0; long = 0.0;
  }

  static double getTotal() {
    double total = 0;
    commandes.forEach((element) {
      total += element.quantite * element.item.foodPrice;
    });

    return total;
  }

  static Future<dynamic> postCommandes() async {

    List commandesListe = [];
    for(var i = 0; i < commandes.length; i++){

      commandesListe.add({
        'product_name' : commandes.elementAt(i).item.foodName,
        'image' : commandes.elementAt(i).item.foodImage,
        'price' : commandes.elementAt(i).item.foodPrice,
        'total_price' : commandes.elementAt(i).item.foodPrice * commandes.elementAt(i).quantite,
        'quantity' : commandes.elementAt(i).quantite,
      });
    }


    final response = await http
        .post(Uri.parse(remoteUrl + '/barcelosapi/empty_vergi_product.php'),
        body: jsonEncode(<String, dynamic>{
          'latitude' : Commandes.lat,
          'longitude' : Commandes.long,
          'commandes' : commandesListe
        }),
        headers: {}
        );


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('La reponse..');
      print(response.body);
      print('Du serveur');
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }




}

