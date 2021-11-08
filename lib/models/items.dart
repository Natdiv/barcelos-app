import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemsModel {
  ItemsModel(
      {required this.foodDescription,
      required this.foodName,
      required this.foodPrice,
      required this.foodRate,
      required this.foodImage});

  final String foodName;
  final String foodDescription;
  final double foodPrice;
  final int foodRate;
  final String foodImage;

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      foodRate: json['foodRate'],
      foodPrice: json['foodPrice'],
      foodName: json['foodName'],
      foodDescription: json['foodDescription'],
      foodImage: json['foodImage']
    );
  }

  static Future<ItemsModel> fetchOneItems() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.112/barcelosapi/empty_vergi_product.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return ItemsModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<dynamic> fetchItems() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.112/barcelosapi/empty_vergi_product.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body)['data']);
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
