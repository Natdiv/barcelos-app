import 'package:barcelos/models/items.dart';


class Commandes {

  final ItemsModel item;
  int quantite;

  Commandes({required this.item, required this.quantite});

  static Set<Commandes> commandes = {};

  static double getTotal() {
    double total = 0;
    commandes.forEach((element) {
      total += element.quantite * element.item.foodPrice;
    });

    return total;
  }

}