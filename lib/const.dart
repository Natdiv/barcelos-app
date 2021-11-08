import 'package:barcelos/models/commandes.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static const Color premierChoix = Color(0XFFFC3901);
  static const Color deuxiemeChoix = Color(0xFF5B8842);
}

typedef AjouterAuPanierCallback = Function(Commandes commandes);
typedef SupprimerDuPanierCallback = Function(Commandes commande);